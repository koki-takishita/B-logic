class AddColumnTimeAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :time_limit, :time
  end
end
