class StudentDetail < ActiveRecord::Base
	belongs_to :student

	#validations

	#age
	validates :age,presence:true
	#college
	#resume
	#experince
	#skills

end
