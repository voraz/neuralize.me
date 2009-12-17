module HasPicture
  
  def create_picture file
    
    if file.class==String
      self.picture = File.open(file) rescue nil
    else
      self.picture = file rescue nil
    end

  end  
  
end
