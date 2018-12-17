class AddHouseIdToMapLocations < ActiveRecord::Migration
  def change
    add_column :map_locations, :house_id, :integer
  end
end
