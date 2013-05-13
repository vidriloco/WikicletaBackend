class CreateTripPois < ActiveRecord::Migration
  def change
    create_table :trip_pois do |t|
      t.string        :name
      t.string        :details
      t.integer       :category
      t.point         :coordinates, :geographic => true
      t.integer       :trip_id
      
      t.string        :icon_name
      t.string        :picture_url
      t.timestamps
    end
  end
end
