class Question < ActiveRecord::Base
  attr_accessor :options_hash

  has_many :test_questions
  has_many :tests ,through: :test_questions

  @options_hash=[]
end
