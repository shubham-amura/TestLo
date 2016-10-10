class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :test

  serialize :response,Hash


  #class methods
  def self.get_results_of_test(test)
    @result=Enrollment.where(test_id:test.id,attempted:true).order(score: :desc).joins(:student).pluck(:name,:username,:email,:score)
    return @result
  end

end
