class AddIndexToTestQuestion < ActiveRecord::Migration
  def change
    #add_index :test_questions,:test_id
    #add_index :test_questions,:question_id

    add_index :test_questions,[:test_id , :question_id],unique: true
  end
end
