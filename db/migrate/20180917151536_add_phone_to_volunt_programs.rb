class AddPhoneToVoluntPrograms < ActiveRecord::Migration
  def change
    add_column :volunt_programs, :phone, :string
  end
end
