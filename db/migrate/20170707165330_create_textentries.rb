class CreateTextentries < ActiveRecord::Migration[5.1]
  def change
    create_table :textentries do |t|
      t.string :data
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
