class AddUseIdFromIssues < ActiveRecord::Migration[5.2]
  def change
    add_reference :issues, :user, foreign_key: true, null: false
  end
end
