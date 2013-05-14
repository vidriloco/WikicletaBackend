class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string         :color
      t.line_string    :path, :geographic => true
      t.string         :details
      t.integer        :trip_id
      t.timestamps
    end
  end
end
