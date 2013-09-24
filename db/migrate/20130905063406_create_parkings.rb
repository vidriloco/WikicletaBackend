class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.point       :coordinates, :geographic => true
      t.string      :details
      t.integer     :kind
      t.boolean     :has_roof
      
      # New fields
      t.integer     :likes_count, :default => 0
      t.integer     :dislikes_count, :default => 0
      
      #t.boolean     :others_can_edit_it
      #t.integer     :user_id
      
      t.timestamps
    end
    
    add_index(:parkings, :coordinates, spatial: true)  # spatial index
    add_index(:parkings, :coordinates, unique: true, :name => 'unique_coordinates_parkings')
    
    # New indexes
    add_index(:parkings, :likes_count)
    add_index(:parkings, :dislikes_count)
  end
end
