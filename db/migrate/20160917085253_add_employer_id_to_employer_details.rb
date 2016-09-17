class AddEmployerIdToEmployerDetails < ActiveRecord::Migration
  def change
  	
  	add_reference :employer_details,:employer,index:true
  	add_foreign_key :employer_details,:employers
  end
end
