class CreateVoluntPrograms < ActiveRecord::Migration
  def change
    create_table :volunt_programs do |t|
      t.string :title
      t.text :photo
      t.string :schedule
      t.integer :quota
      t.string :short_description
      t.text :long_description
      t.integer :id_category

      t.timestamps null: true
    end
  end
end
