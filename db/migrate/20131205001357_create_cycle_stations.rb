class CreateCycleStations < ActiveRecord::Migration
  def change
    create_table :cycle_stations do |t|
      t.string      :name
      t.integer     :number
      t.integer     :free_slots
      t.integer     :bikes_available
      t.point       :coordinates, :geographic => true
      t.string      :agency
      t.timestamps
    end
  end
end
