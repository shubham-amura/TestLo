class TestQuestion < ActiveRecord::Base
  belongs_to :test
  belongs_to :question

  after_save :change_test

 #marks validation
  validates :marks ,
            numericality: { only_integer: true}

#class methods
  def self.getTestQuestion

  end

  def self.create_test_question(test_id,question_id,marks)
    TestQuestion.create(test_id:test_id,question_id:question_id,marks:marks)
  end

  private

  def change_test
      @test=Test.find(test_id)
      @test.change_marks(marks)
      @test.change_number_of_questions(1)
      @test.save
  end
end
