class Question < ActiveRecord::Base
  attr_accessor :a,:b,:c,:d
  serialize :options,Array
  serialize :correct_answer,Array
  #with test

  has_many :test_questions
  has_many :tests ,through: :test_questions

  #with category
  belongs_to :category

  #validations
  validates :question ,presence:true
end
