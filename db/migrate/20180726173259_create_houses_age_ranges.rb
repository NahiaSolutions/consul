class CreateHousesAgeRanges < ActiveRecord::Migration
  def change
    create_table :houses_age_ranges do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
