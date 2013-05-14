class AddLikesCountToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :likes_count, :integer, :default => 0
  end
end
