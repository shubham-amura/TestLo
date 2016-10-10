require 'faker'

FactoryGirl.define do

  factory :enrollment do |f|

    f.student_id   { Faker::Number.between(0,2) }
    f.test_id     { Faker::Number.number(2)    }
    f.score       {Faker::Number.number(2)     }
  end
end
