class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :code, null: false, limit: 50, index: true
      t.text :value, null: false
      t.string :condition, limit: 100, index: true
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
