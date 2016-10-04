class Test < ActiveRecord::Base
  #with questions
  has_many :test_questions,dependent: :destroy
  has_many :questions, through: :test_questions

  #with Employer
  belongs_to :employer

  #with student
  has_many :enrollments,dependent: :destroy
  has_many :students ,through: :enrollments


  #validaions
end
