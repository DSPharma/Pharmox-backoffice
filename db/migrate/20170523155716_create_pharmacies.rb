class CreatePharmacies < ActiveRecord::Migration[5.1]
  def change
    create_table :pharmacies do |t|
      t.integer :cip
      t.string :name
      t.string :address
      t.integer :postal_code
      t.string :city
      t.string :phone_number

      t.timestamps
    end
  end
end
