class AddStatusToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :status, :string
  end
end
