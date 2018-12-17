class CreateHousesAdministrators < ActiveRecord::Migration
  def change
    create_table :houses_administrators do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
