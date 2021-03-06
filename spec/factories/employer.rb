require 'faker'

FactoryGirl.define do
  factory :employer do |f|

    f.email    {  Faker::Internet.email        }
    f.name     {  Faker::Name.first_name             }
    f.phone_no {  Faker::Number.number(10)}
    f.username {  Faker::Internet.user_name[0..8] }
    f.password {  Faker::Internet.password     }
  end
end
