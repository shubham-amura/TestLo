class AddEmployerIdToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :employer, index: true, foreign_key: true
  end
end
