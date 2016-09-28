class CreatePaymentMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_methods do |t|
      t.string :icon, null: false, limit: 40
      t.string :name, null: false, limit: 50
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
