class DatasetsController < ApplicationController

  def find_all
      render :json=> Dataset.all.collect{ 
        |r|{
          :id=>r.id.to_s,
          :title=>r.title
        }
      }
  end
       
  def lines_and_columns
    dataset = Dataset.find( ActiveSupport::JSON.decode(params["0"])["id"] )
    lines = dataset.lines
    lines.each_index do |i|
      lines[i] = {:index=>i, :data=>lines[i]}
    end
    render :json=>{:lines=>lines, :columns=>dataset.columns}
  end
  
  def find_by_id
    render :json=>Dataset.first
  end
   
   
end
