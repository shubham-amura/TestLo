require 'spec_helper'

describe StudentDetail do
  describe "Age" do

    it "should be present" do
      build(:student_detail,age:nil).should_not be_valid
    end

    it "should be number" do
      build(:student_detail,age:"AA").should_not be_valid
    end

    it "should pass if number" do
      build(:student_detail,age:12).should be_valid
    end

  end

  describe "Experience" do

    it "should be present" do
      build(:student_detail,experience:nil).should_not be_valid
    end

    it "should be number" do
      build(:student_detail,experience:"AA").should_not be_valid
    end

  end

  describe "College" do

    it "should be present" do
      build(:student_detail,college:nil).should_not be_valid
    end

    it "should pass if college is valid" do
      build(:student_detail,college:"MIT").should be_valid
    end

    it "should contain alphabetics" do
      build(:student_detail,college:"MIT123").should_not be_valid
    end

    it "should be less than 20 characters" do
      build(:student_detail,college:"A"*50).should_not be_valid
    end


  end

  describe "Skills" do
    it "shoul fail if skills are empty" do
      build(:student_detail,skills:nil).should_not be_valid
    end

    it "shoul pass if skills are not empty" do
      build(:student_detail,skills:"python,c++").should be_valid
    end
  end

  describe "Resume" do
      it "should be present" do
        build(:student_detail,resume:nil).should_not be_valid
      end

      it "should fail if invalid format" do
        build(:student_detail,resume:"AAA").should_not be_valid
      end

      it "should pass with valid format " do
        build(:student_detail,resume:"https://abc.com").should be_valid
      end
  end

  describe "associations" do
    it "belongs to student" do
      assc = described_class.reflect_on_association(:student)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
