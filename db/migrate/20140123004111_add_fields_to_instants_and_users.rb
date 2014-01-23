class AddFieldsToInstantsAndUsers < ActiveRecord::Migration
  def up
    add_column :instants, :distance, :decimal
    add_column :instants, :user_id, :integer
    
    add_column :users, :distance, :decimal
    add_column :users, :speed, :decimal
    add_column :users, :guru_points, :decimal
  end
  
  def down
    remove_column :instants, :distance
    remove_column :instants, :user_id
    
    remove_column :users, :distance
    remove_column :users, :speed
    remove_column :users, :guru_points
  end
end
