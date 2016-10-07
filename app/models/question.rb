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





  def option_map_for_different_question_type
    case self.question_type
      when 0
        if !self.options[0].empty? || !self.options[1].empty? || !self.options[2].empty? || !self.options[3].empty?
          errors.add(:options,"Options not allowed for integer type")
        end
      when 1
        if self.options[0].empty? && self.options[1].empty? && self.options[2].empty? && self.options[3].empty?
          errors.add(:options,"Needs all options")
        end
      when 2
        if self.options[0].empty? && self.options[1].empty? && self.options[2].empty? && self.options[3].empty?
          errors.add(:options,"Needs all option")
        end
      end
  end

end
