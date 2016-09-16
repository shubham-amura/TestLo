# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do |t|

  question="This is sample Question"
  question_type=rand(0..2)

  if question_type==0
    options=[]
    correct_answer=[Faker::Color.color_name]
  else
    options=[Faker::Color.color_name,Faker::Color.color_name,Faker::Color.color_name,Faker::Color.color_name]
    if question_type==1
      correct_answer=[options[rand(0..4)]]
    else
      correct_answer=[options[1],options[3]]
    end
  end

  q=QuestionBank.new(question_type:question_type,question:question,options:options.join('###'),correct_answer:correct_answer.join('###'))
  q.save

end
