class AddDigestedPathFieldToRoutes < ActiveRecord::Migration
  def up
    add_column :routes, :digested_path, :text
  end
  
  def down
    remove_column :routes, :digested_path
  end
end
