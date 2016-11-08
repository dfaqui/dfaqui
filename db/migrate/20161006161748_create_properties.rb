class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.references :customer, foreign_key: true, null: false, index: true
      t.references :block, foreign_key: true, null: false, index: true
      t.string :address_complement, limit: 255
      t.integer :property_type, null: false
      t.integer :commercial_situation, null: false
      t.integer :release_status, null: false
      t.text :description
      t.integer :price
      t.integer :tax
      t.integer :area, null: false
      t.integer :square_meter_price
      t.integer :rooms, null: false
      t.integer :bathrooms, null: false
      t.integer :parking_spaces
      t.string :floor, limit: 45
      t.integer :unit
      t.integer :maintenance_fee
      t.integer :sun_position
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
