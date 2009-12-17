class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.references  :student
      t.references  :discipline
      t.decimal     :note,      :precision=>10,   :scale=>2

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
