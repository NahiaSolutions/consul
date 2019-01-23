class AddDisabilityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disability, :boolean, default: false
  end
end
