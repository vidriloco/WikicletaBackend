class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string          :name
      t.string          :details
      t.integer         :city_id
      t.string          :picture_name
      
      t.string          :periodicity
      t.timestamps
    end
  end
end
