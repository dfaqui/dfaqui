class CreateCustomerCommons < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_commons do |t|
      t.string :fantasy_name, null: false, limit: 120
      t.text :description
      t.string :logo, limit: 100
      t.string :image_secure_token, limit: 255
      t.string :plugin, null: false, limit: 20
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
