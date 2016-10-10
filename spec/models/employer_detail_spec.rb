require 'spec_helper'

describe EmployerDetail do

  context "Company name" do

    it "should be present" do
      build(:employer_detail,company:nil).should_not be_valid
    end

    it "should be less than 20 characters" do
      build(:employer_detail,company:"a"*21).should_not be_valid
    end

    it "should pass if company name is valid" do
      build(:employer_detail,company:"Amura").should be_valid
    end


  end

  context "Company address" do

    it "should be present" do
      build(:employer_detail,company_address:nil).should_not be_valid
    end

    it "should be less than 30 characters" do
      build(:employer_detail,company_address:"a"*31).should_not be_valid
    end

    it "should pass if address is valid" do
      build(:employer_detail,company_address:"Pune ,balewadi").should be_valid
    end
  end

  context "Company contact" do

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

      it "should pass if valid" do
        build(:employer_detail,contact:"9"*11).should be_valid
      end
  end

    context "associations" do
      it "belongs to employer" do
        assc = described_class.reflect_on_association(:employer)
        expect(assc.macro).to eq :belongs_to
      end

    end

end
