class Question < ActiveRecord::Base
  serialize :options,Array
  #with test
  has_many :test_questions
  has_many :tests ,through: :test_questions

  #with category
  belongs_to :category
end
