class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.references :customer, foreign_key: true, null: false, index: true
      t.references :block, foreign_key: true, null: false, index: true
      t.integer :property_type, null: false
      t.integer :commercial_situation, null: false
      t.integer :release_status, null: false
      t.text :description
      t.float :price
      t.float :tax
      t.integer :area, null: false
      t.float :square_meter_price
      t.integer :rooms, null: false
      t.integer :bathrooms, null: false
      t.integer :parking_spaces, null: false
      t.integer :floor
      t.string :sun_position, limit: 20

      t.timestamps
    end
  end
end
