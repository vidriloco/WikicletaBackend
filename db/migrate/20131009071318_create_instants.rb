class CreateInstants < ActiveRecord::Migration
  def change
    create_table :instants do |t|
      t.point       :coordinates, :geographic => true
      t.decimal     :speed
      t.integer     :elapsed_time, :limit => 8
      t.integer     :route_performance_id
      t.timestamps
    end
  end
end
