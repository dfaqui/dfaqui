class CreateMarketPaymentMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :market_payment_methods do |t|
      t.references :market, foreign_key: true, null: false
      t.references :payment_method, foreign_key: true, null: false

      t.timestamps
    end

    add_index :market_payment_methods, [:market_id, :payment_method_id], unique: true
  end
end
