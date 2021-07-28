class AddReferencesKeyFromTask < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :issue, foreign_key: true
  end
end
