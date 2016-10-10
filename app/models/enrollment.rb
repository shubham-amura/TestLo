class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :test

  serialize :response,Hash

  validates :test_id,
                    presence:true

  validates :student_id,
                      presence:true

  validates :score,
                  numericality:true

  validates :attempted, inclusion: { in: [ true, false ] }
  

  #instance method
  def record_start_time
    if self.start_time.nil?
      self.start_time=DateTime.now
      self.save
    end
  end

  def get_start_time
    self.start_time.getlocal
  end

  def save_response_for_question(response,question_id)
    unless (response.nil? || response.empty? || question_id.nil? || question_id.empty?)
      self.response[question_id]=response.is_a?(Array) ? response:[response]
      self.save
    end
  end

  def get_user_response
    self.response
  end

  def set_score(score)
    self.score=score
    set_attempted
    save
  end

  def set_attempted
    self.attempted=true
  end

  def submit_test
    @score=0
    #get user response
    user_response_hash=self.get_user_response
    #get correct response
    @test_questions=TestQuestion.get_test_questions_join(self.test_id)
    #calculate score
    @test_questions.each do |t|
      if user_response_hash["#{t.question.id}"]==t.question.correct_answer
        @score+=t.marks
      end
    end
    set_score(@score)
    #save score
    #lock_test
    return @score
  end

  #class methods
  def self.get_results_of_test(test)
    @result=Enrollment.where(test_id:test.id,attempted:true).order(score: :desc).joins(:student).pluck(:name,:username,:email,:score)
    return @result
  end

  def self.get_enrollment_for_test(test,current_user)
      #current enrollment
      Enrollment.find_by(test_id:test.id,student_id:current_user.id)
  end

  def self.enroll_user_for_test(test,current_user)
    Enrollment.create(test_id:test.id,student_id:current_user.id)
  end

  def self.tests_enrolled_by_user(current_user)
    #listss of tests enrolled by user
    Enrollment.where(student_id:current_user.id)
  end


end
