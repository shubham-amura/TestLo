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

  #Validation Methods

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

  #Instance Methods
  def change_number_of_questions(number)
    self.number_of_questions+=number
  end

  def change_marks(marks)
    self.marks+=marks
  end

  def change_privacy
    self.toggle(:private)
    self.save
  end

  def change_activity
    self.toggle(:active)
    self.save
  end

  #Class Methods
  def self.employer_test_which_are(current_user,query_type)
      case query_type
      when "active"
        Test.all.where(employer_id: current_user.id,active:true)
      when "inactive"
        Test.all.where(employer_id: current_user.id,active:false)
      when "public"
        Test.all.where.not(employer_id:current_user.id).where(active:true,private:false)
      else
        Test.all.where(employer_id: current_user.id)
      end
  end

  def self.get_test_by_id(test_id)
    find(test_id)
  end
end
