require 'spec_helper'

describe EmployerDetail do

  describe "Company name" do

    it "should be present" do
      build(:employer_detail,company:nil).should_not be_valid
    end

    it "should be less than 10 characters" do
      build(:employer_detail,company:"a"*11).should_not be_valid
    end

  end

  describe "Company address" do

    it "should be present" do
      build(:employer_detail,company_address:nil).should_not be_valid
    end

    it "should be less than 30 characters" do
      build(:employer_detail,company_address:"a"*31).should_not be_valid
    end
  end

  describe "Company contact" do

      it "should be present" do
        build(:employer_detail,contact:nil).should_not be_valid
      end

      it "should be numeric" do
        build(:employer_detail,contact:"9023224fff").should_not be_valid
      end

      it "not less than 10" do
        build(:employer_detail,contact:"9").should_not be_valid
      end

      it "not more than 15" do
        build(:employer_detail,contact:"9"*16).should_not be_valid
      end
  end

end
