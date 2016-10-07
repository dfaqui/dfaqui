class CreateSponsorItems < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsor_items do |t|
      t.references :sponsorable, polymorphic: true, null: false, index: true
      t.integer :order, null: false
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
