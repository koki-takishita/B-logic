class RenameColumnFormTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :task, :name
  end
end
