require "lib/kohonen/distribution"
require "lib/kohonen/distance"

class Train
  include MongoMapper::Document
  include Distance
  include Distribution

  $use_c = true

  attr_accessor :inputs, :weights, :alphas, :ranges, :range, :alpha

  key :weight_lines, Integer
  key :weight_columns, Integer
  key :dataset_id
  key :training_times, Integer
  key :start_range, Integer
  key :end_range, Integer
  key :start_alpha, Float
  key :end_alpha, Float

  key :finished, Boolean
  key :results, Array

  key :randomize_weights, Boolean, :default=>true
  key :start_random_weights, Float, :default=>0
  key :end_random_weights, Float, :default=>100
  
  key :current_training_time, Integer
  key :start_at, Time
  key :end_at, Time
  
  
  timestamps!

  def self.generate
    Train.new(:weight_lines=>15, :weight_columns=>15, :dataset_id=>Dataset.first.id, :training_times=>500, :start_range=>7, :end_range=>2, :start_alpha=>0.1, :end_alpha=>0.01)
  end

  def self.test_rb
    $use_c = false
    generate.start
  end
  def self.test_c
    $use_c = true
    generate.start
  end


  def start
    update_attributes(:finished=>false, :start_at=>Time.now)
    
    create_inputs
    create_weights
    
    @ranges = distribute(start_range, end_range, training_times, true)
    @alphas = distribute(start_alpha, end_alpha, training_times, false)

    train()
  end

  def create_inputs()
    @inputs = Dataset.find(dataset_id).lines_to_matrix
    @inputs.map! do |r|
      r.map! do |s|
        s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/)==nil ? s=s.unpack("C*").sum : s=s.to_f
      end
    end
  end

def create_weights
  if randomize_weights
    z_size = @inputs.max{|x,y| x.size<=>y.size}.size
    min_max = Array.new(z_size){[]}

    z_size.times do |i|
      @inputs.size.times do |j|
        min_max[i][0] = [ min_max[i][0], @inputs[j][i] ].min rescue @inputs[j][i]
        min_max[i][1] = [ min_max[i][1], @inputs[j][i] ].max rescue @inputs[j][i]
      end
    end
    @weights = Array.new(weight_columns){ Array.new(weight_lines){ Array.new(z_size){ |i| rand(min_max[i][1]-min_max[i][0])+min_max[i][0]      } } }
  else
    @weights = Array.new(weight_columns){ Array.new(weight_lines){ Array.new(z_size){ |i| rand(end_random_weights-start_random_weights)+start_random_weights      } } }
  end
end


  def relative_alpha(closer, range)
    @alpha/(index_distance(closer, range)+1)
  end

  def learn(input, closer)
    @weights.each_index do |i|
      @weights[i].each_index do |j|
        p = [i, j]

        if in_range(p, closer, @range)
          @weights[i][j].each_index do |k|
            @weights[i][j][k] += relative_alpha(closer,p) * (input[k]-@weights[i][j][k])
          end
        elsif index_distance(closer, p)==@range+1
          @weights[i][j].each_index do |k|
            @weights[i][j][k] -= relative_alpha(closer,p) * (input[k]-@weights[i][j][k])
          end
        end

      end
    end
  end

  def update_positions(time)
    result = []
    @inputs.each_index do |i|
       point = closer(@inputs[i], @weights)
       result << {:index=>i, :x=>point[0], :y=>point[1]}
    end
    results << result
    update_attributes(:results=>results, :current_training_time=>time)
  end

  def train
    @training_times.times do |time|
      
      @alpha = @alphas[time]
      @range = @ranges[time]
      
      puts "Step: #{time+1}/#{@training_times}"
      @inputs.each do |input|
        #puts "Step: #{time+1}/#{@training_times}    #{@inputs.index(input)}/#{@inputs.size}"
        closer = closer(input, @weights)
        learn(input, closer)

        #if time % 1 == 0
          #Print.step(time, input, @range, @alpha)
          #colorized(@weights, closer, @range)
        #end
      end
      update_positions(time)
    end
    update_attributes(:finished=>true, :end_at=>Time.now)
  end


end
