class Test < ActiveRecord::Base
  #with questions
  has_many :test_questions
  has_many :questions, through: :test_questions

  #with Employer
  belongs_to :employer
end
