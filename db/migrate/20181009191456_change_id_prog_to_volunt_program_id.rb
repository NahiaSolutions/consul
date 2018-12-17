class ChangeIdProgToVoluntProgramId < ActiveRecord::Migration
  def change
    rename_column :volunt_users, :id_prog, :volunt_program_id
  end
end
