class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer     :rank
      t.integer     :kind,  :default => 0
      t.integer     :user_id
      t.references  :owned_object, :polymorphic => true
      t.timestamps
    end
    
    add_index(:ownerships, [:user_id, :owned_object_id, :owned_object_type], :unique => true, :name => 'unique_object_owners_index')
    
  end
end
