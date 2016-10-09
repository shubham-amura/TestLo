require 'spec_helper'



describe TestQuestion, type: :model do

  describe "Question validaions check for Marks" do

    it "text inalid if marks are character" do
      build(:test_question,marks:"Sad").should_not be_valid

  end

  end
end
