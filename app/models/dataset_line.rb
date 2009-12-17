class DatasetLine
  include MongoMapper::Document
  include HasPicture

  key :data, Array
  
  mount_uploader :picture, PictureUploader
  
  def to_json(options = {})
    super({:methods => [:pictures]}.merge(options))
  end
  
  def pictures
    picture.pictures
  end
  
end
