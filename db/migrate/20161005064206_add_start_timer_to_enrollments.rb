class AddStartTimerToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :start_time, :datetime
  end
end
