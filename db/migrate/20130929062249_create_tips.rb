class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string      :content
      t.integer     :category # peligro, alerta, turismo
      t.point       :coordinates, :geographic => true
      
      t.integer     :likes_count, :default => 0
      # New fields
      t.integer     :dislikes_count, :default => 0
      
      t.integer     :user_id     
      t.timestamps
    end
    
    add_index(:tips, :coordinates, spatial: true)  # spatial index
    add_index(:tips, :coordinates, unique: true, :name => 'unique_coordinates_tips')
    
    # New indexes
    add_index(:tips, :likes_count)
    add_index(:tips, :dislikes_count)
  end
end
