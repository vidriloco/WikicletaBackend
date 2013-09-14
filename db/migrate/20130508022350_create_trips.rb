class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string          :name
      t.string          :slug
      t.string          :details
      t.point           :coordinates, :geographic => true
      t.string          :picture_name

      t.string          :periodicity
      t.timestamps
    end
    
    add_index :trips, :slug, unique: true
  end
end
