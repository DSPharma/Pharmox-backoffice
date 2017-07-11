class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.boolean :type
      t.string :title
      t.string :product_concerned

      t.timestamps
    end
  end
end
