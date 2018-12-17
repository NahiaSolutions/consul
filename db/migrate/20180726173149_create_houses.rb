class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :name
      t.string :address
      t.string :schedule
      t.string :phone
      t.string :email
      t.string :photo
      t.boolean :disability_access
      t.integer :id_administration

      t.timestamps null: true
    end
  end
end