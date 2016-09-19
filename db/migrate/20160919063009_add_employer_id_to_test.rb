class AddEmployerIdToTest < ActiveRecord::Migration
  def change
    add_reference :tests,:employer,index:true
  	add_foreign_key :tests,:employers
  end
end
