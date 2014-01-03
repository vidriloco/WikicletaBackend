class CreateCyclePaths < ActiveRecord::Migration
  def change
    create_table :cycle_paths do |t|
      t.string          :name
      t.string          :details
      t.decimal         :kilometers
      t.line_string     :path, :srid => 4326, :geographic => true
      t.point           :origin_coordinate, :geographic => true
      t.point           :end_coordinate, :geographic => true
      t.boolean         :one_way
      t.integer         :city_id
      t.timestamps
    end
  end
end
