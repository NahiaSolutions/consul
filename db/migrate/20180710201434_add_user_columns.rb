class AddUserColumns < ActiveRecord::Migration
  def change
    add_column :users, :userlastname, :string
    add_column :users, :user_parish, :integer
    add_column :users, :user_neighborhood, :integer
    add_column :users, :ethnic_group, :string
    add_column :users, :studies_level, :string
  end
end
