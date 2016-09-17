class AddStudentIdToStudentDetails < ActiveRecord::Migration
  def change
  	add_reference :student_details,:student,index:true
  	add_foreign_key :student_details,:students
  end
end
