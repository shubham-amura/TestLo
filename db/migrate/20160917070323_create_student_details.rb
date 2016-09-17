class CreateStudentDetails < ActiveRecord::Migration
  def change
    create_table :student_details do |t|
      t.integer :age
      t.string :college
      t.string :resume
      t.integer :experience
      t.string :skills

      t.timestamps null: false
    end
  end
end
