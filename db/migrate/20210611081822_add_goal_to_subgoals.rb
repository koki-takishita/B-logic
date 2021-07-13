class AddGoalToSubgoals < ActiveRecord::Migration[5.2]
  def change
    add_reference :subgoals, :goal, foreign_key: true
  end
end
