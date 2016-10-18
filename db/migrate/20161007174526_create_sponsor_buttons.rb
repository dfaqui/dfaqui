class CreateSponsorButtons < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsor_buttons do |t|
      t.references :customer, foreign_key: true, null: false, index: true
      t.references :city, foreign_key: true, null: false, index: true
      t.string :image, null: false
      t.integer :order, null: false
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
