class CreateSubgoals < ActiveRecord::Migration[5.2]
  def change
    create_table :subgoals do |t|
      t.string :embodiment
      t.integer :quantification
      t.string :unit
      t.string :subgoal
      t.integer :status, default: 0
      t.datetime :deadline_on
      t.timestamps
    end
  end
end
