class CreateDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :districts do |t|
      t.string :name, null: false, limit: 100
      t.references :district_group, foreign_key: true, null: false, index: true
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
