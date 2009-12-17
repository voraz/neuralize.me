class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
  
  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def pictures
    file.blank? ? nil : {:thumb=>URI::escape(thumb.url), :small=>URI::escape(small.url), :grid=>URI::escape(grid.url)}
  end

  # Provide a default URL as a default if there hasn't been a file uploaded
  #     def default_url
  #       "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  #     end

  # Process files as they are uploaded.
  #     process :scale => [200, 300]
  #
  #     def scale(width, height)
  #       # do something
  #     end

  # Create different versions of your uploaded files
  version :thumb do
    process :resize_to_fit => [365,215]
  end
  version :small do
    process :resize_to_fit => [120,100]
  end
  version :grid do
    process :resize_to_fit => [50,50]
  end  


  # Add a white list of extensions which are allowed to be uploaded,
  # for images you might use something like this:
  #     def extension_white_list
  #       %w(jpg jpeg gif png)
  #     end

  # Override the filename of the uploaded files
  #     def filename
  #       "something.jpg" if original_filename
  #     end

end
