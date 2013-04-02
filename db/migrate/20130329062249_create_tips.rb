class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string      :content
      t.integer     :category # peligro, alerta, turismo
      t.point       :coordinates, :srid => 4326, :with_z => false 
      
      t.integer     :likes_count, :default => 0
      t.integer     :user_id     
      t.timestamps
    end
  end
end
