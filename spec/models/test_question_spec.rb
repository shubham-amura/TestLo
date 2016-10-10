require 'spec_helper'



describe TestQuestion, type: :model do

  describe "Question validaions check for Marks" do

    it "text invalid if marks are character" do
      build(:test_question,marks:"Sad").should_not be_valid
    end

    it "test pass if marks are valid" do
      build(:test_question,marks:100).should be_valid
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
        build(:test_question,question_id:22).should be_valid
    end
  end

  describe "associations" do
    it "belongs to test" do
      assc = described_class.reflect_on_association(:test)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to question" do
      assc = described_class.reflect_on_association(:question)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
