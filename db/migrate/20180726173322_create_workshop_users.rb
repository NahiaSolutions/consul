class CreateWorkshopUsers < ActiveRecord::Migration
  def change
    create_table :workshop_users do |t|
      t.integer :id_user
      t.integer :id_workshop

      t.timestamps null: true
    end
  end
end
