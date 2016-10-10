require 'spec_helper'


describe Test, type: :model do

  describe "Duration Validation on Test Model" do

    it "invalid if zero duration is used" do
      expect(build(:test,duration:Time.parse("00:00:00"))).to_not be_valid
    end

    it "invalid marks are invalid" do
      expect(build(:test,marks:"abc")).to_not be_valid
    end
  end

    describe "associations" do

    it "has many questions" do
      assc = described_class.reflect_on_association(:questions)
      expect(assc.macro).to eq :has_many
    end

    it "has many test questions" do
      assc = described_class.reflect_on_association(:test_questions)
      expect(assc.macro).to eq :has_many
    end

    it "has many enrollments" do
      assc = described_class.reflect_on_association(:enrollments)
      expect(assc.macro).to eq :has_many
    end

    it "has many students" do
      assc = described_class.reflect_on_association(:students)
      expect(assc.macro).to eq :has_many
    end

    it "has belongs to employer" do
      assc = described_class.reflect_on_association(:employer)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
