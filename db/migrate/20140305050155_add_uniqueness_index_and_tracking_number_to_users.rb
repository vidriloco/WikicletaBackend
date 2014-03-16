class AddUniquenessIndexAndTrackingNumberToUsers < ActiveRecord::Migration
  def up
    add_column :users, :tracking_number, :string
    add_column :users, :tracking_number_last_reset_at, :datetime
    
    execute <<-SQL
      CREATE UNIQUE INDEX users_uniqueness_username_case_insensitive_index ON users (LOWER(username));
    SQL
    
    add_index(:users, :tracking_number, name: :tracking_number_users_index, unique: true)
  end

  def down
    remove_column :users, :tracking_number
    remove_column :users, :tracking_number_last_reset_at
    
    execute <<-SQL
      DROP INDEX users_uniqueness_username_case_insensitive_index;
    SQL
    
  end
end
