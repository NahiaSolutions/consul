class CreateZonalAdministrations < ActiveRecord::Migration
  def change
    create_table :zonal_administrations do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
