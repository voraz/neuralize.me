class ImporterController < ApplicationController
  
  def txt_to_array
     separator = params[1] ||= ","
     file = params[0]

     render :amf=>ImporterHelper.to_a(file, separator)
   end
   
end