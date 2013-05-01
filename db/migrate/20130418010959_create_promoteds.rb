class CreatePromoteds < ActiveRecord::Migration
  def change
    create_table :promoteds do |t|
      t.string      :headline, :limit => 20
      t.string      :main_details, :limit => 33
      t.text        :extra_details
      
      t.integer     :likes_count, :default => 0
      t.integer     :promoter_info_id
      t.timestamps
    end
  end
end
