require 'spec_helper'

describe Student, type: :model do

  it "has one student detail" do
    assc = described_class.reflect_on_association(:student_detail)
    expect(assc.macro).to eq :has_one
  end

end
