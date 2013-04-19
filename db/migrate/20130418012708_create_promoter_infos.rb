class CreatePromoterInfos < ActiveRecord::Migration
  def change
    create_table :promoter_infos do |t|
      t.string          :name
      t.string          :email
      t.string          :phone
      t.string          :address
      t.text            :tags
      t.integer         :city_id
      t.integer         :user_id
      t.timestamps
    end
    
    add_index(:promoter_infos, :coordinates, spatial: true)  # spatial index
    add_index(:promoter_infos, :coordinates, unique: true, :name => 'unique_coordinates_promoter_infos')
  end
end
