class ChangeIdCategoryToVoluntCategoryId < ActiveRecord::Migration
  def change
    rename_column :volunt_programs, :id_category, :volunt_category_id
  end
end
