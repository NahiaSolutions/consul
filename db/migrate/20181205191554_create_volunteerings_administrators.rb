class CreateVolunteeringsAdministrators < ActiveRecord::Migration
  def change
    create_table :volunteerings_administrators do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
