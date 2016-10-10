require 'spec_helper'

describe Question, type: :model do
  describe "Question type and Option validation " do
      it "Question type validation check" do
        build(:question,question_type: 4).should_not be_valid
      end
      it "Question Type 0 then Option should be null" do
        build(:question,question_type:0, options: ["sd","","",""] ).should_not be_valid
      end
  end

  describe "Question Type and Correct Answer" do
      it "Correct Answer check for Integer Type" do
          build(:question,question_type: 0,correct_answer:["","","",""]).should_not be_valid
      end
      it "Correct Answer check for Multiple Type" do
          build(:question,question_type: 2,correct_answer:["df","","",""]).should_not be_valid
          build(:question,question_type: 2,correct_answer:[" ","","",""]).should_not be_valid
          build(:question,question_type: 2,correct_answer:["df","dfsd","",""]).should be_valid
      end
      it "Correct Answer check for Single Type" do
          build(:question,question_type: 1,correct_answer:["df","","",""]).should be_valid
          build(:question,question_type: 1,correct_answer:["","","",""]).should_not be_valid
          build(:question,question_type: 1,correct_answer:["df","dfsd","",""]).should_not be_valid
      end
  end

    describe "associations" do
      it "has many test_questions" do
        assc = described_class.reflect_on_association(:test_questions)
        expect(assc.macro).to eq :has_many
      end

      it "has many tests" do
        assc = described_class.reflect_on_association(:tests)
        expect(assc.macro).to eq :has_many
      end

      it "belongs to employer" do
        assc = described_class.reflect_on_association(:employer)
        expect(assc.macro).to eq :belongs_to
      end

      it "belongs to category" do
        assc = described_class.reflect_on_association(:category)
        expect(assc.macro).to eq :belongs_to
      end

    end
end
