class AddStartTimerToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :start_time, :time
  end
end
