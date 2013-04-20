class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.string    :details
      t.string    :code
      t.integer   :status, :default => 1
      t.integer   :banned, :default => 0
      t.boolean   :fake, :default => false
      t.string    :email
      t.point     :location, :geographic => true
      
      t.timestamps
    end
    
    add_index(:stickers, :location, :spatial => true)
  end
end
