class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :name, null: false, limit: 100
      t.string :email, null: false, limit: 100
      t.string :phone, limit: 20
      t.string :content, null: false
      t.references :messageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
