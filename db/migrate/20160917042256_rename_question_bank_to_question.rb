class RenameQuestionBankToQuestion < ActiveRecord::Migration
  def change
    rename_table :question_banks, :questions
  end
end
