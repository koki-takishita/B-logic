class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :type, default: 0
      t.string :task
      t.datetime :deadline_on
      t.timestamps
    end
  end
end
