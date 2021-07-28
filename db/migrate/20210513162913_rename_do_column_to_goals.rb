class RenameDoColumnToGoals < ActiveRecord::Migration[5.2]
  def change
    rename_column :goals, :do, :what_to_do
  end
end
