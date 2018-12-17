class CreateVoluntCategories < ActiveRecord::Migration
  def change
    create_table :volunt_categories do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
