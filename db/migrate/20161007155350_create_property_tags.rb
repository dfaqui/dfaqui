class CreatePropertyTags < ActiveRecord::Migration[5.0]
  def change
    create_table :property_tags do |t|
      t.references :property, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false
    end

    add_index :property_tags, [:property_id, :tag_id], unique: true
  end
end
