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
  has_many :test_questions,dependent: :destroy
  has_many :tests ,through: :test_questions

  #with category
  belongs_to :category

  #validations
  validates :question,
                      presence:true
  validates :question_type,
                          presence:true,
                          numericality: { only_integer: true,greater_than_or_equal_to:0,less_than_or_equal_to:2}

  #options
  #correct_answers

end
