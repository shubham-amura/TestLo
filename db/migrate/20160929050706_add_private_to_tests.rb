class AddPrivateToTests < ActiveRecord::Migration
  def change
    add_column :tests, :private, :boolean,default:true
  end
end
