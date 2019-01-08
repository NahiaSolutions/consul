class FixHousesColumnsNames < ActiveRecord::Migration
  def change
    rename_column :houses, :id_administration, :zonal_administration_id
    rename_column :house_news, :id_house, :house_id
    rename_column :workshops, :id_house, :house_id
    rename_column :workshop_users, :id_workshop, :workshop_id
  end
end
