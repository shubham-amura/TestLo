class CreateQuestionBanks < ActiveRecord::Migration
  def change
    create_table :question_banks do |t|
      t.integer :question_type
      t.string :question
      t.string :options
      t.string :correct_answer

      t.timestamps null: false
    end
  end
end
