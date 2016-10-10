require 'faker'

FactoryGirl.define do

  factory :employer_detail do |f|

    f.company             { Faker::Company.name }
    f.company_address     { Faker::Address.city    }
    f.contact             { Faker::Number.number(10)    }
  end
end
