class ChangeColumnDefaultToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :status, from: nil, to: 0
  end
end
