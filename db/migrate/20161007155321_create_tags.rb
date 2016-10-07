class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false, limit: 100
      t.string :plugin, null: false, limit: 20
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
