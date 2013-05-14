class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string  :description
      t.integer :kind
      t.boolean :complaint_issued
      t.integer :lock_used
      
      t.string  :vehicle_identifier
      t.point   :coordinates, :geographic => true
      t.date    :date
      t.time    :start_hour
      t.time    :final_hour
      t.integer :user_id
      t.integer :bike_id

      t.boolean :solved, :default => false

      t.timestamps
    end
    
    add_index(:incidents, :coordinates, spatial: true)  # spatial index
    add_index(:incidents, :coordinates, unique: true, :name => 'unique_coordinates_incidents')
  end
end
