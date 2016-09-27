class EmployerDetail < ActiveRecord::Base
	belongs_to :employer


	#validations

	#company
	#company_address
	#contact
	validates :company,
										presence:true

	validates :company_address,
										presence:true

	validates :contact,
										presence:true

end
