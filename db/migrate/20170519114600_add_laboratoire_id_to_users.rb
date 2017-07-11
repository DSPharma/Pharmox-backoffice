class AddLaboratoireIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :laboratory, foreign_key: true
  end
end
