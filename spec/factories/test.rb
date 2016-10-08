require 'faker'

FactoryGirl.define do
  factory :test do |f|

    f.name {Faker::Name.name}
    f.date {Faker::Date.between(Date.today , 1.year.from_now)}

    

  end
end
