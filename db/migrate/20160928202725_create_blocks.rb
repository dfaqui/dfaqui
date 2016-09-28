class CreateBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :blocks do |t|
      t.string :name, null: false, limit: 20
      t.references :district, foreign_key: true, null: false, index: true
      t.string :zipcode, limit: 9
      t.string :tour_link, limit: 255
      t.float :latitude
      t.float :longitude
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
