class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :category
      t.string :name
      t.date :date
      t.time :duration
      t.integer :number_of_questions
      t.integer :marks

      t.timestamps null: false
    end
  end
end
