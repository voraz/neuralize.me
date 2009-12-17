# == Schema Information
#
# Table name: disciplines
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Discipline < ActiveRecord::Base
  has_many :notes
end
