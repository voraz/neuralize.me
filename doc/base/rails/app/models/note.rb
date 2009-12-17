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

class Note < ActiveRecord::Base
  belongs_to :student
  belongs_to :discipline
end
