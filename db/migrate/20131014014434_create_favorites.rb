class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer     :user_id, :null => false
      t.references  :favorited_object, :polymorphic => true, :null => false
      t.timestamps
    end
    
    add_index(:favorites, [:user_id, :favorited_object_id, :favorited_object_type], :unique => true, :name => 'unique_object_favorites_index')
    
  end
end
