class AddLikesColumnsToRoutes < ActiveRecord::Migration
  def change
    add_column        :routes, :likes_count, :integer, :default => 0
    add_column        :routes, :dislikes_count, :integer, :default => 0
  end
end
