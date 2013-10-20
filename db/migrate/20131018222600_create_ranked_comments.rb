class CreateRankedComments < ActiveRecord::Migration
  def change
    create_table :ranked_comments do |t|
      t.boolean     :positive
      t.string      :content, :null => false
      t.integer     :user_id, :null => false
      t.references  :ranked_comment_object, :polymorphic => true, :null => false
      t.integer     :ranked_comment_id
      t.timestamps
    end
    
    add_index(:ranked_comments, [:user_id, :ranked_comment_object_id, :ranked_comment_object_type, :content], :unique => true, :name => 'unique_object_ranked_object_index')    
  end
  
  def down
    [Tip, Workshop, Parking, Route].each do |klass|
      klass.all.each { |item| item.update_attributes({:likes_count => 0, :dislikes_count => 0}) }
    end
  end
end
