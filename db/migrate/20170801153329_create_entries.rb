class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :kind
      t.string :title
      t.string :num_campaign

      t.timestamps
    end
  end
end
