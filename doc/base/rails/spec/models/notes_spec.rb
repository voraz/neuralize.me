# == Schema Information
#
# Table name: notes
#
#  id            :integer(4)      not null, primary key
#  student_id    :integer(4)
#  discipline_id :integer(4)
#  note          :decimal(10, 2)
#  created_at    :datetime
#  updated_at    :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Notes do
  before(:each) do
    @valid_attributes = {
      :student => ,
      :discipline => ,
      :note => 
    }
  end

  it "should create a new instance given valid attributes" do
    Notes.create!(@valid_attributes)
  end
end
