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

class Student < ActiveRecord::Base
  has_many :notes
end
