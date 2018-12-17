class AddEmailToVoluntPrograms < ActiveRecord::Migration
  def change
    add_column :volunt_programs, :email, :string
  end
end
