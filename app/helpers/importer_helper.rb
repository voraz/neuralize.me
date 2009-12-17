module ImporterHelper

  def self.open_file(file)
    file.pack("c"*file.size) rescue file
  end

  def self.dataset(file, separator=",")
    result = []
    open_file(file).to_a.each do |l|
      l.gsub!("\n","")
      s = l.split(separator)
      result << s if s.blank? == false
    end
    result
  end

  def self.datadescription(file, column_separator="\n", description_separator=",")
    result = []
    open_file(file).to_a.each do |r|
      begin
        s = r.split(description_separator)
        result << {:title=>s[0], :description=>s[1].split(column_separator)[0], :included=>s[2].split(column_separator)[0]} if s.blank? == false
      rescue
      end
    end
    result
  end

end

