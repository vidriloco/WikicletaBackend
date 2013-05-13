class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.point       :coordinates, :geographic => true
      t.string      :details
      t.integer     :kind
      t.boolean     :has_roof
      t.boolean     :others_can_edit_it
      t.integer     :user_id
      
      t.integer     :likes_count, :default => 0
      
      t.timestamps
    end
    
    add_index(:parkings, :coordinates, spatial: true)  # spatial index
    add_index(:parkings, :coordinates, unique: true, :name => 'unique_coordinates_parkings')
  end
end
