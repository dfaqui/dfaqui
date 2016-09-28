class CreateDistrictGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :district_groups do |t|
      t.string :name, null: false, limit: 60
      t.references :city, foreign_key: true, null: false, index: true
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
