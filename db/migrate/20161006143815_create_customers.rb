class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name, limit: 120
      t.references :customer_common, foreign_key: true, null: false, index: true
      t.references :block, foreign_key: true, null: false, index: true
      t.integer :customer_type, null: false
      t.string :document, null: false, limit: 20
      t.string :address_complement, limit: 255
      t.string :owner_name, null: false, limit: 120
      t.string :owner_email, null: false, limit: 100
      t.string :owner_phone, limit: 20
      t.string :contact_email, null: false, limit: 100
      t.string :contact_phone, array: true, default: []
      t.string :additional_info, limit: 255
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
