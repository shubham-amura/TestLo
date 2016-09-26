class Question < ActiveRecord::Base
  attr_accessor :a,:b,:c,:d

  #This doesnt work.
  #serialize :options, Array
  #serialize :correct_answer,:options, Array

  #This works
  [:correct_answer,:options].each do |t|
    serialize t,Array
  end


  #with test
  has_many :test_questions
  has_many :tests ,through: :test_questions

  #with category
  belongs_to :category

  #validations
  validates :question ,presence:true
end
