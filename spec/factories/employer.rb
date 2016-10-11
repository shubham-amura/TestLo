require 'faker'

FactoryGirl.define do
  factory :employer do |f|

    f.email    {  Faker::Internet.email        }
    f.name     {  Faker::Name.first_name             }
    f.phone_no {  Faker::Number.number(10)}
    f.username {  Faker::Pokemon.name[0..6]  }
    f.password {  Faker::Internet.password     }



  end
end
