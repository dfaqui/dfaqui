class CreateCityMarkets < ActiveRecord::Migration[5.0]
  def change
    create_table :city_markets do |t|
      t.references :city, foreign_key: true, null: false
      t.references :market, foreign_key: true, null: false

      t.timestamps
    end

    add_index :city_markets, [:city_id, :market_id], unique: true
  end
end
