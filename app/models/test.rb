class Test < ActiveRecord::Base
  #with questions
  has_many :test_questions
  has_many :questions, through: :test_questions

  #with Employer
  belongs_to :employer

  #with student
  has_many :enrollments
  has_many :students ,:through :enrollments
end
