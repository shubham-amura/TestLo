class Question < ActiveRecord::Base
  has_many :test_questions
  has_many :tests ,through: :test_questions
end
