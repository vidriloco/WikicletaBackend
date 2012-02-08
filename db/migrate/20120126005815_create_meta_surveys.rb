class CreateMetaSurveys < ActiveRecord::Migration
  def change
    create_table :meta_surveys do |t|
      t.string :name
      t.integer :category_id
      t.timestamps
    end
  end
end
