require 'spec_helper'


describe User, type: :model do

  describe "Name Validation on User Model" do

    it "invalid if number are used" do
      build(:user,name: 131).should_not be_valid
    end

    it "Invalid if special characters are used" do
        build(:user,name: "!@U^" ).should_not be_valid
    end

    it "Invalid if numerics and special character are used" do
        build(:user,name: "ajsdh@218%^$" ).should_not be_valid
    end

  end

  describe "Number validation of user phone" do

    it "Invalid phone number" do
      user = build(:user,phone_no: "8726371f21" )
      byebug
      user.should_not be_valid
    end
  end



end
