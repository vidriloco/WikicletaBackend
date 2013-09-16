class CreateCities < ActiveRecord::Migration
  def down
    drop_table :cities if table_exists?(:cities)
  end
  
  def up
    create_table :cities do |t|
      t.integer     :alt_id
      t.string      :country_code
      t.string      :name
      t.point       :coordinates, :geographic => true
      t.timestamps
    end
    
    add_index(:cities, :coordinates, spatial: true)  # spatial index
    add_index(:cities, [:name, :country_code], :unique => true)
    add_index(:cities, :alt_id, :unique => true)
  end
end
