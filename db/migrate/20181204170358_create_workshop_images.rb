class CreateWorkshopImages < ActiveRecord::Migration
  def change
    create_table :workshop_images do |t|
      t.integer :workshop_id

      t.timestamps null: false
    end
  end
end
