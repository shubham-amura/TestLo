class ChangeMarksFromTests < ActiveRecord::Migration
  def up
  change_column :tests, :marks, :integer, default: 0
  change_column :tests, :number_of_questions,:integer, default: 0
end

def down
  change_column :tests, :marks, :integer, default: nil
  change_column :tests, :number_of_questions, :integer, default: nil
end
end
