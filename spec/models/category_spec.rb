require 'spec_helper'

describe Category, type: :model do

  it "has many questions" do
    assc = described_class.reflect_on_association(:questions)
    expect(assc.macro).to eq :has_many
  end

end
