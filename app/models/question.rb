class Question < ActiveRecord::Base
  attr_accessor :a,:b,:c,:d

  #This doesnt work.
  #serialize :options, Array
  #serialize :correct_answer,:options, Array

  #This works
  [:correct_answer,:options].each do |t|
    serialize t,Array
  end


  #with test
  has_many :test_questions,dependent: :destroy
  has_many :tests ,through: :test_questions

  #with category
  belongs_to :category

  #
  belongs_to :employer

  #validations
  validates :question,
                      presence:true

  validates :question_type,
                          presence:true,
                          numericality: { only_integer: true,greater_than_or_equal_to:0,less_than_or_equal_to:2}

  #options
  validate :option_map_for_different_question_type

  #correct_answers
  validate :correct_answers_map_for_different_question_type




  def option_map_for_different_question_type
    case self.question_type
      when 0
        if self.options.any?{|x| !x.empty? }
          errors.add(:options,"Options not allowed for integer type")
        end
      when 1
        if self.options.all?{|x| x.empty? } 
          errors.add(:options,"Needs all options")
        end
      when 2
        if self.options.all?{|x| x.empty? }
          errors.add(:options,"Needs all option")
        end
      end
  end

  def correct_answers_map_for_different_question_type

    case self.question_type
    when 0
      if correct_answer[0].empty?
        errors.add(:correct_answer,"Need answer for integer type")
      end

    when 1
      if no_of_answer != 1
        errors.add(:correct_answer,"Incorrect  number of answer")
      end

    when 2

      if no_of_answer < 2
        errors.add(:correct_answer,"Incorrect  number of answer")
      end

    end
  end

  def no_of_answer
    number = 0
    correct_answer.each do |x|
      number += 1 if !x.empty?
    end
      return number
    end


end
