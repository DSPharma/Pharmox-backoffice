class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :name
      t.string :description
      t.string :image_base
      t.references :campaign, foreign_key: true
      t.references :entry, foreign_key: true

      t.timestamps
    end
  end
end
