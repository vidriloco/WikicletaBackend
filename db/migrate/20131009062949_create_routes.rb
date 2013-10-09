class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string          :name
      t.string          :details
      t.boolean         :is_public
      t.decimal         :kilometers
      t.line_string     :path, :srid => 4326
      t.point           :origin_coordinate, :geographic => true
      t.point           :end_coordinate, :geographic => true
      
      t.integer         :comfort_index
      t.integer         :speed_index
      t.integer         :safety_index   
      t.timestamps
    end
  end
end
