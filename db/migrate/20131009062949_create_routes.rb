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
      
      t.integer         :likes_count, :default => 0
      t.integer         :dislikes_count, :default => 0
      
      t.integer         :comfort_index, :default => 0
      t.integer         :speed_index, :default => 0
      t.integer         :safety_index, :default => 0
      t.timestamps
    end
  end
end
