require 'faker'

FactoryGirl.define do

  factory :question do |f|

    f.question_type {Faker::Number.between(0,2) }
    f.employer_id   {Faker::Number.number(2)    }
    f.category_id   {Faker::Number.number(2)    }
    f.question      {Faker::Lorem.sentence      }
    f.correct_answer {Faker::Lorem.words(4)   }
    f.options        {Faker::Lorem.words(4)     }

  end


end


# t.integer  "question_type"
# t.string   "question"
# t.string   "options"
# t.string   "correct_answer"
# t.datetime "created_at",     null: false
# t.datetime "updated_at",     null: false
# t.integer  "category_id"
# t.integer  "employer_id"
