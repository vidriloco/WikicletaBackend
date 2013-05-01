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
    
  end
end
