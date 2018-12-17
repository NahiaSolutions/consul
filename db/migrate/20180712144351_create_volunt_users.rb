class CreateVoluntUsers < ActiveRecord::Migration
  def change
    create_table :volunt_users do |t|
      t.integer :id_user
      t.integer :id_prog

      t.timestamps null: true
    end
  end
end
