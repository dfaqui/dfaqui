class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :code, null: false, limit: 50
      t.text :content
      t.string :plugin, null: false, limit: 20
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
