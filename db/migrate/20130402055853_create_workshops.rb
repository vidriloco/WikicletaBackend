class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string      :name
      t.string      :details
      t.boolean     :store
      
      t.integer     :phone, :limit => 8
      t.integer     :cell_phone, :limit => 8
      t.string      :webpage
      t.string      :twitter
      
      t.string      :horary
      t.point       :coordinates, :geographic => true
      t.integer     :likes_count, :default => 0
      # New fields
      t.integer     :dislikes_count, :default => 0
      
      #t.integer     :user_id
      #t.integer     :promoter_info_id
      #t.boolean     :others_can_edit_it
      
      
      t.timestamps
    end
    
    add_index(:workshops, :coordinates, spatial: true)  # spatial index
    add_index(:workshops, :coordinates, unique: true, :name => 'unique_coordinates_workshops')
    
    # New indexes
    add_index(:workshops, :likes_count)
    add_index(:workshops, :dislikes_count)
  end
end
