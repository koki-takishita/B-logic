class RemoveCoulmsFormGoal < ActiveRecord::Migration[5.2]
  def change
    change_table :goals do |t|
      t.remove :embodiment, :quantification, :unit, :what_to_do, :deadline_on
      t.string :name
      t.datetime :deadline 
    end
  end
end
