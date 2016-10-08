require 'faker'

FactoryGirl.define do

  factory :test_question do |f|

    f.marks    {Faker::Number.number(2)}
    f.test_id  {Faker::Number.number(2)}
    f.question_id {Faker::Number.number(2)}
  end

end
