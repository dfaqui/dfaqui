class AddSlugToDistrictGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :district_groups, :slug, :string
    add_index :district_groups, :slug, unique: true
  end
end
