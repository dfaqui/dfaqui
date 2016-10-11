class CreateMarkets < ActiveRecord::Migration[5.0]
  def change
    create_table :markets do |t|
      t.references :customer, foreign_key: true, null: false, index: true
      t.references :segment, foreign_key: true, null: false, index: true
      t.integer :price_category
      t.boolean :always_open, null: false, default: false
      t.boolean :delivery, null: false, default: false
      t.boolean :only_delivery, null: false, default: false
      t.integer :estimated_time
      t.string :estimated_time_suffix, limit: 10

      t.timestamps
    end
  end
end
