require 'faker'

FactoryGirl.define do
  factory :user do |f|

    f.email    {  Faker::Internet.email        }
    f.name     {  Faker::Name.name             }
    f.phone_no {  Faker::PhoneNumber.cell_phone}
    f.username { "djbsfbsi"  }
    f.password {  Faker::Internet.password     }


  end
end
