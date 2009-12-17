class TrainsController < ApplicationController
  
  def find_all
      render :json=> Train.find(:all, :select=>"id, dataset_id, weight_lines, weight_columns, training_times, start_range, end_range, start_alpha, end_alpha, randomize_weights, start_random_weights, end_random_weights, finished, current_training_time").collect{ 
        |r|{
          :id=>r.id.to_s,
          :dataset_title=>Dataset.find(r.dataset_id).title,
          
          :weights=>"#{r.weight_lines} x #{r.weight_columns}",
          :training_times=>r.training_times,
          :range=>"#{r.start_range} .. #{r.end_range}",
          :alpha=>"#{r.start_alpha} .. #{r.end_alpha}",
          :weights_range=>( r.randomize_weights ? "auto" : "#{r.start_random_weights} .. #{r.end_random_weights}"),
          :finished=>r.finished,
          :step=>("#{r.current_training_time+1} / #{r.training_times}" rescue "")
        }
      }
  end
   
  def find_by_id
    train = Train.find( JSON.parse(params["0"])["id"] )
    dataset = Dataset.find( train.dataset_id )
    lines = dataset.lines
    lines.each_index do |i| 
      lines[i] = {:index=>i, :data=>lines[i]}
    end
    render :json=>{:lines=>lines, :columns=>dataset.columns, :train=>train}
  end
  
  def start
    par = JSON.parse(params["0"])

    train = Train.create(  :weight_lines           => par["weight_lines"],
                        :weight_columns         => par["weight_columns"],
                        :dataset_id             => par["dataset_id"],
                        :training_times         => par["training_times"],
                        :start_range            => par["start_range"],
                        :end_range              => par["end_range"],
                        :start_alpha            => par["start_alpha"],
                        :end_alpha              => par["end_alpha"],
                        :randomize_weights      => par["randomize_weights"],
                        :start_random_weights   => par["start_random_weights"],
                        :end_random_weights     => par["end_random_weights"]
                        )
    call_rake :train_kohonen, :train_id=>train.id

    render :json=>{:id=>train.id.to_s}
  end


  def last_result
    train = Train.find( JSON.parse(params["0"])["id"] )
    puts "#{train.current_training_time}/#{train.training_times}"
    puts "# time: #{(Time.now-train.start_at).round}sec   #{(Time.now-train.start_at)/60}min"  
    
    render :json=>{:finished=>train.finished, :result=>train.results.last}
  end

  def full_result
    train = Train.find( JSON.parse(params["0"])["id"] )
    puts "# Finished in: #{(train.end_at-train.start_at).round}sec   #{(train.end_at-train.start_at)/60}min"  
    render :json=>{:results=>train.results}
  end


end

