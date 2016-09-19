class AddStudentIdToStudentDetails < ActiveRecord::Migration
  def change
    add_column :student_details, :student_id, :integer
      end
end
