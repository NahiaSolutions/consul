class AddDatesToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :start_date, :date
    add_column :workshops, :end_date, :date
  end
end
