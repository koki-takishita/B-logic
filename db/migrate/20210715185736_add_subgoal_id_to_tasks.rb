class AddSubgoalIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :subgoal, foreign_key: true
  end
end
