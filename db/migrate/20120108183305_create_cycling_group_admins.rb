class CreateCyclingGroupAdmins < ActiveRecord::Migration
  def change
    create_table :cycling_group_admins do |t|
      t.integer     :cycling_group_id    
      t.integer     :user_id
      t.integer     :permissions
      t.boolean     :verified
      t.timestamps
    end
    
    add_index :cycling_group_admins, [:cycling_group_id, :user_id], :unique => true
  end
end
