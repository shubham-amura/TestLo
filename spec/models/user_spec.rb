require 'spec_helper'


describe User, type: :model do

  describe "Name Validation on User Model" do

    it "invalid if number are used" do
      FactoryGirl.build(:user,name: 131).should_not be_valid
    end
    
  end

end
