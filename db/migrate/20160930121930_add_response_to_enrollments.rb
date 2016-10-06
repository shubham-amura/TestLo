class AddResponseToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :response, :string
  end
end
