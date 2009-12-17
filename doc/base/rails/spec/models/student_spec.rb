# == Schema Information
#
# Table name: students
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  ra         :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Student do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :ra => 
    }
  end

  it "should create a new instance given valid attributes" do
    Student.create!(@valid_attributes)
  end
end
