class CreateHouseNews < ActiveRecord::Migration
  def change
    create_table :house_news do |t|
      t.string :title
      t.string :photo
      t.string :link
      t.integer :id_house
		
      t.timestamps null: false
    end
  end
end
