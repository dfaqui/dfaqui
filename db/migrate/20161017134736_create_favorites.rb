class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.references :favoritable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
