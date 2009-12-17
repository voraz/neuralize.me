class Dataset
  include MongoMapper::Document
  
  many :columns, :class_name=>"DatasetColumn"
  key :dataset_lines, Array
  key :title, String
  key :description, String

  timestamps!

  def lines
    dataset_lines.map {|r| DatasetLine.find(r) }
  end

  def to_json(options = {})
    super({:methods => [:lines]}.merge(options))
  end

  def lines_to_matrix
    data = lines.map {|l| l.data }
    
    data.each_index do |i|
      tmp = []
      columns.each_index do |j|
        if columns[j].included
          tmp.push( data[i][j] )
        end
      end
      data[i]=tmp
    end
    data
  end
  
  def matrix_to_flex
    matrix = lines_to_matrix
    matrix.each do |l|
      l.each_index do |i|
        l[i] = {"#{i}"=>l[i]}
      end
    end
    matrix
  end

end

