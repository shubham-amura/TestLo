require 'spec_helper'

describe User, type: :model do
  describe "Name Validation on User Model" do

    it "should fail if name is nil" do
        build(:user,name:nil).should_not be_valid
    end

    it "should fail if name is invalid" do
        build(:user,name: 131).should_not be_valid
    end

    it "Invalid if special characters are used" do
        build(:user,name: "!@U^" ).should_not be_valid
    end

    it "Invalid if numerics and special character are used" do
        build(:user,name:"ajsdh@218%^$" ).should_not be_valid
    end

    it "should pass if valid name is given" do
        build(:user,name:"swapnil").should be_valid
    end
  end

  describe "Username" do
    it "should fail if username is nil" do
        build(:user,username:nil).should_not be_valid
    end

    it "should fail if username is invalid" do
        build(:user,username:131).should_not be_valid
    end

    it "should fail if username is invalid" do
        build(:user,username:"@#%^").should_not be_valid
    end

    it "should pass if username is valid" do
        build(:user,username:"assaf").should be_valid
    end
  end

  describe "Number validation of user phone" do

    it "should fail if Invalid phone number" do
      build(:user,phone_no:"8726371f21").should_not be_valid
    end

    it "should fail if Invalid phone number" do
      build(:user,phone_no:"87").should_not be_valid
    end

    it "should fail if Invalid phone number" do
      build(:user,phone_no:"872637121111111111111111").should_not be_valid
    end


    it "should pass if valid phone number" do
      build(:user,phone_no:"8726371121").should be_valid
    end
  end

  describe "Email" do
    it "should pass if email is valid" do
      build(:user,email:"swapb@gm.com").should be_valid
    end

    it "should fail if invalid email" do
      build(:user,email:"abc").should_not be_valid
    end

    it "should fail if email is nil" do
      build(:user,email:nil).should_not be_valid
    end
  end
end
