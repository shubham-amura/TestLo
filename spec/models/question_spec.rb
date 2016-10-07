require 'spec_helper'

describe Question, type: :model do

  describe "Question type and validation " do

      it "Question type validation check" do
        build(:question,question_type: 4).should_not be_valid
      end

      it "Question Type 0 then Option should be null" do
        build(:question,question_type:0, options: ["sd","","",""] ).should_not be_valid
      end

    end
end
