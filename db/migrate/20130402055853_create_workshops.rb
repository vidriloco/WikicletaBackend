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
      t.boolean     :others_can_edit_it
      t.point       :coordinates, :geographic => true
      t.integer     :user_id
      
      t.timestamps
    end
    
    add_index(:workshops, :coordinates, spatial: true)  # spatial index
    add_index(:workshops, :coordinates, unique: true, :name => 'unique_coordinates_workshops')
  end
end
