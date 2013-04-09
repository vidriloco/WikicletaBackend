class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string      :code
      t.point       :coordinates, :geographic => true
      t.timestamps
    end
    
    add_index(:cities, :coordinates, spatial: true)  # spatial index
    
  end
end
