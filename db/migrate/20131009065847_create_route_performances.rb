class CreateRoutePerformances < ActiveRecord::Migration
  def change
    create_table :route_performances do |t|
      t.decimal       :average_speed
      t.integer       :elapsed_time, :limit => 8
      t.integer       :user_id
      t.integer       :route_id
      t.timestamps
    end
  end
end
