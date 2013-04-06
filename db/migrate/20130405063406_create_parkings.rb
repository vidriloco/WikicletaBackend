class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.point       :coordinates, :srid => 4326, :with_z => false 
      t.string      :details
      t.integer     :kind
      t.boolean     :has_roof
      t.boolean     :others_can_edit_it
      t.integer     :user_id
      t.timestamps
    end
  end
end
