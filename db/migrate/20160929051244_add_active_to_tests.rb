class AddActiveToTests < ActiveRecord::Migration
  def change
    add_column :tests, :active, :boolean,default:false
  end
end
