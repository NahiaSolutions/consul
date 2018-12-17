class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :teacher
      t.string :schedule
      t.integer :quota
      t.string :short_description
      t.text :long_description
      t.string :photo
      t.integer :id_house
      t.integer :id_age_range

      t.timestamps null: true
    end
  end
end
