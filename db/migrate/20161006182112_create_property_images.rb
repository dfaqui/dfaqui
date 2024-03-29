class CreatePropertyImages < ActiveRecord::Migration[5.0]
  def change
    create_table :property_images do |t|
      t.references :property, foreign_key: true, null: false, index: true
      t.string :image, null: false
      t.string :name, null: false, limit: 100
      t.integer :order, null: false
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
