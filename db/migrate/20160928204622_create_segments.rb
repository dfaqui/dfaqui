class CreateSegments < ActiveRecord::Migration[5.0]
  def change
    create_table :segments do |t|
      t.string :name, null: false, limit: 100
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
