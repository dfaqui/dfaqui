class CreateCategoryMarkets < ActiveRecord::Migration[5.0]
  def change
    create_table :category_markets do |t|
      t.references :category, foreign_key: true, null: false
      t.references :market, foreign_key: true, null: false

      t.timestamps
    end

    add_index :category_markets, [:category_id, :market_id], unique: true
  end
end
