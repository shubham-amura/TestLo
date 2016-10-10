require 'faker'

FactoryGirl.define do

  factory :student_detail do |f|
    f.age               { Faker::Number.number(2) }
    f.college           { Faker::Educator.secondary_school }
    f.resume            { Faker::Internet.url    }
    f.experience         { Faker::Number.number(2)   }
    f.skills            { Faker::Hipster.paragraph }
  end
end
