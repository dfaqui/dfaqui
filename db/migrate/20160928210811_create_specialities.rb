class CreateSpecialities < ActiveRecord::Migration[5.0]
  def change
    create_table :specialities do |t|
      t.string :name, null: false, limit: 100
      t.references :category, foreign_key: true, null: false, index: true
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
