class TestQuestion < ActiveRecord::Base
  belongs_to :test
  belongs_to :question


 #marks validation
  validates :marks ,
            numericality: { only_integer: true}



end
