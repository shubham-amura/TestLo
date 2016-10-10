class StudentDetail < ActiveRecord::Base
	belongs_to :student

	#validations

	#age
	validates :age,
								presence:true,
								numericality:true

	validates :college,
										format: { with: /\A[a-zA-Z\s\.]+\z/,message: "only allows letters" },
										presence:true,
										length:{maximum:40,message:"college length exceeds limit"}

	#resume
	validates :resume,
										presence:true,
										format:URI::regexp(%w(http https))
	#experince
	validates :experience,
											presence:true,
											numericality:true

	#skills
	validates :skills,
										presence:true

end
