class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, limit: 60
      t.text :description
      t.references :market, foreign_key: true, null: false, index: true
      t.string :photo
      t.string :image_secure_token
      t.float :price
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
