class DatasetColumn
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :description, String
  key :included, Boolean, :default=>true
  key :dataset_id, String
  
  belongs_to :dataset
  
  def to_json(options = {})
    super()
  end
  
end
