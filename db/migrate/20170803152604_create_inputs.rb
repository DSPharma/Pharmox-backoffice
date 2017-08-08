class CreateInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :inputs do |t|
      t.string :value
      t.references :entry, foreign_key: true
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
