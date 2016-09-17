class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :company
      t.string :company_address
      t.string :contact
      t.integer :no_of_tests
      t.integer :active_tests

      t.timestamps null: false
    end
  end
end
