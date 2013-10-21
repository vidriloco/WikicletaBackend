class CreateRouteRankings < ActiveRecord::Migration
  def change
    create_table :route_rankings do |t|
      t.integer     :user_id, :null => false
      t.integer     :route_id, :null => false
      t.integer     :speed_index, :default => 0
      t.integer     :comfort_index, :default => 0
      t.integer     :safety_index, :default => 0
      t.timestamps
    end
    
    add_index(:route_rankings, [:user_id, :route_id], :unique => true, :name => 'unique_route_ranking_index')    
    
  end
end
