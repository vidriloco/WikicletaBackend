class AddUniquenessIndexToUsers < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE UNIQUE INDEX users_uniqueness_username_case_insensitive_index ON users (LOWER(username));
    SQL
  end

  def down
    execute <<-SQL
      DROP INDEX users_uniqueness_username_case_insensitive_index;
    SQL
  end
end
