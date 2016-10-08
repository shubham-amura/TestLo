require 'spec_helper'


describe Test, type: :model do

  describe "Duration Validation on Test Model" do

    it "invalid if zero duration is used" do
      expect(build(:test,duration:Time.parse("00:00:00"))).to_not be_valid
    end



  end

end
