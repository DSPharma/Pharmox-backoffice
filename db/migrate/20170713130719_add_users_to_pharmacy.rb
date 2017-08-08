class AddUsersToPharmacy < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :pharmacy, foreign_key: true
  end
end
