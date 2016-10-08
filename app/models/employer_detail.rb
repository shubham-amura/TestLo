class EmployerDetail < ActiveRecord::Base
	belongs_to :employer


	#validations

	#company
	#company_address
	#contact
	validates :company,
										presence:true,
										length:{maximum:20,message:"Comapny name should have < 20 characters"}
	validates :company_address,
										presence:true

	validates :contact,
										presence:true


end
