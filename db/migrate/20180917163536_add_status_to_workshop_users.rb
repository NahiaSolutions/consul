class AddStatusToWorkshopUsers < ActiveRecord::Migration
  def change
    add_column :workshop_users, :status, :integer
  end
end
