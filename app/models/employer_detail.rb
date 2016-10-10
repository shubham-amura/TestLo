class EmployerDetail < ActiveRecord::Base
	belongs_to :employer


	#validations

	#company
	#company_address
	#contact
	validates :company,
										presence:true,
										length:{maximum:10,message:"Comapny name should have < 10 characters"}

	validates :company_address,
										presence:true,
										length:{maximum:30,message:"Comapny address should have < 30 characters"}

	validates :contact,
										presence:true,
										format: { with: /\A\d+\z/ ,message: "Must contain only numbers"},
										length: { minimum: 10,maximum:15,message: "Must be 10-15 digits"}
end
