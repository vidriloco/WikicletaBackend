class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer     :user_id
      t.integer     :ring
      t.string      :permissions
      t.timestamps
    end
    
    add_index(:user_roles, [:user_id, :ring], :unique => true, :name => 'user_roles_ring_index')    
  end
end
