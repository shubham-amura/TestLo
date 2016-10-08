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
  #testname validation
  validates :name ,
            uniqueness: true,
            presence:   true

  #date validation
  validate :test_date_cannot_be_in_the_past

  #duration validation
  validates :duration,
             presence: true

  validate :duration_greater_than_zero

  def duration_greater_than_zero
    if self.duration.seconds_since_midnight == 0
      errors.add(:duration, "can't be zero")
    end
  end

  def test_date_cannot_be_in_the_past
    if date.present? && date < DateTime.now.utc.to_date
          errors.add(:date, "can't be in the past")
    end
  end

end
