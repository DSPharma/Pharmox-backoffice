class AddEnrollementCodeToPharmacy < ActiveRecord::Migration[5.1]
  def change
    add_column :pharmacies, :enrollement_code, :string
  end
end
