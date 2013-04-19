class CreateUserLikePromoteds < ActiveRecord::Migration  
  def change
    create_table :user_like_promoteds do |t|
      t.integer :user_id
      t.integer :promoted_id
      t.timestamps
    end
    
    add_index :user_like_promoteds, [:user_id, :promoted_id], :unique => true, :name => "uniqueness_promoted_likes_idx"
  end
end
