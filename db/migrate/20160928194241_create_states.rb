class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name, null: false, limit: 60
      t.string :abbreviation, null: false, limit: 20
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
