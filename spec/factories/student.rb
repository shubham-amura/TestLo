require 'faker'

FactoryGirl.define do
  factory :student do |f|

    f.email    {  Faker::Internet.email        }
    f.name     {  Faker::Name.name             }
    f.phone_no {  "9860328030" }
    f.username { "djbsfbsi"  }
    f.password {  Faker::Internet.password     }
  end
end
