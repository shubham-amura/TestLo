class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :test

  serialize :response,Hash




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

  #class methods
  def self.get_results_of_test(test)
    @result=Enrollment.where(test_id:test.id,attempted:true).order(score: :desc).joins(:student).pluck(:name,:username,:email,:score)
    return @result
  end


end
