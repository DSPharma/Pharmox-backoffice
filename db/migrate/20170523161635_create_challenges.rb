class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :product
      t.datetime :start_at
      t.datetime :end_at
      t.string :target
      t.string :statut_type
      t.references :user, foreign_key: true
      t.references :laboratory, foreign_key: true
      t.references :pharmacy, foreign_key: true

      t.timestamps
    end
  end
end
