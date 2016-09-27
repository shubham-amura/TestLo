class ChangeDurationFromTests < ActiveRecord::Migration
  def change
    change_column :tests,:duration,:time
  end
end
