require 'spec_helper'

describe Enrollment do

  it "should not pass if marks are nil" do
      build(:enrollment,score:nil).should_not be_valid
  end

  it "should not pass if marks are invalid" do
      build(:enrollment,score:"ABC").should_not be_valid
  end

  it "should pass if marks valid" do
      build(:enrollment,score:100).should be_valid
  end
end
