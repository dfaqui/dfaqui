class CreateMarketSpecialities < ActiveRecord::Migration[5.0]
  def change
    create_table :market_specialities do |t|
      t.references :market, foreign_key: true, null: false
      t.references :speciality, foreign_key: true, null: false

      t.timestamps
    end

    add_index :market_specialities, [:market_id, :speciality_id], unique: true
  end
end
