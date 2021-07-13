class RemoveUserFromSubgoal < ActiveRecord::Migration[5.2]
  def change
    remove_reference :subgoals, :user, foreign_key: true
  end
end
