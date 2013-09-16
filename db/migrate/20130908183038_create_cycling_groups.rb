class CreateCyclingGroups < ActiveRecord::Migration
  def change
    create_table :cycling_groups do |t|
      t.string          :name
      t.string          :slug
      
      t.string          :details
      t.string          :meeting_time
      t.string          :departing_time

      t.string          :periodicity
      t.string          :twitter_account
      t.string          :facebook_url
      t.string          :website_url
      t.point           :coordinates, :geographic => true
      
      t.timestamps
    end
    
    add_index :cycling_groups, :slug, unique: true
  end
end
