class DropTableSubgoals < ActiveRecord::Migration[5.2]
  def change
    drop_table :subgoals
  end
end
