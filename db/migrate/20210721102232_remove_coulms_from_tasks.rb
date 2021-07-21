class RemoveCoulmsFromTasks < ActiveRecord::Migration[5.2]
  def change
    change_table :tasks do |t|
      t.remove :subgoal_id, :deadline_on, :time_limit
      t.datetime :reminder
    end
  end
end
