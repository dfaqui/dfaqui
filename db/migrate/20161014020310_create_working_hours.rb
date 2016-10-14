class CreateWorkingHours < ActiveRecord::Migration[5.0]
  def change
    create_table :working_hours do |t|
      t.references :market, foreign_key: true, null: false, index: true
      t.string :days, array: true, default: []
      t.time :opening_time, null: false
      t.time :closing_time, null: false
    end
  end
end
