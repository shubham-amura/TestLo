require 'spec_helper'

describe Employer, type: :model do

  it "has one student detail" do
    assc = described_class.reflect_on_association(:employer_detail)
    expect(assc.macro).to eq :has_one
  end

end
