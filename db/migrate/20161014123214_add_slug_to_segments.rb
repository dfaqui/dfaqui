class AddSlugToSegments < ActiveRecord::Migration[5.0]
  def change
    add_column :segments, :slug, :string
    add_index :segments, :slug, unique: true
  end
end
