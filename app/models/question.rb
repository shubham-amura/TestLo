class Question < ActiveRecord::Base

  #with test
  has_many :test_questions
  has_many :tests ,through: :test_questions

  #with category
  belongs_to :category
end
