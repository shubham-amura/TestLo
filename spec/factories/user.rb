require 'faker'

FactoryGirl.define do
  factory :user do |f|

    f.email    {  Faker::Internet.email        }
    f.name     {  Faker::Name.name             }
    f.phone_no {  Faker::Number.number(10)}
    f.username {  Faker::Internet.user_name('Swapnil')  }
    f.password {  Faker::Internet.password     }



  end
end
