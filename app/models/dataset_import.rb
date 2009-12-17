class DatasetImport

  def self.import(name, title, extension="jpg")
    d = Dataset.new(:title=>title)
    lines = ImporterHelper.dataset(File.open("datasets/#{name}/#{name}.data"))
    lines.each do |r|
      line = DatasetLine.new( :data=>r)
      line.create_picture("datasets/#{name}/images/#{r[0].downcase}.#{extension}")
      line.save
      d.dataset_lines << line.id
    end

    columns = ImporterHelper.datadescription(File.open("datasets/#{name}/#{name}.names"), "\n", " # ")
    columns.each do |r|
      d.columns << DatasetColumn.new(:title=>r[:title], :description=>r[:description], :included=>r[:included])
    end

    d.save
  end

end
