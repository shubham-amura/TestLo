class AddAttemptedToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :attempted, :boolean,default:false
  end
end
