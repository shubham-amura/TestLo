require 'spec_helper'



describe TestQuestion, type: :model do

  describe "Question validaions check for Marks" do

    it "text inalid if marks are character" do
      build(:test_question,marks:"Sad").should_not be_valid
    end

    it "should fail if test_id is invalid" do
      build(:test_question,test_id:nil).should_not be_valid
    end

    it "should pass if test_id is valid" do
      build(:test_question,test_id:22).should be_valid
    end

    it "should pass if question_id is nil" do
      build(:test_question,question_id:nil).should_not be_valid
    end

    it "should pass if question_id is valid" do
        build(:test_question,test_id:22).should be_valid
    end
  end
end
