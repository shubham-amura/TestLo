class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :age
      t.string :college
      t.string :resume
      t.integer :experience
      t.string :skills

      t.timestamps null: false
    end
  end
end
