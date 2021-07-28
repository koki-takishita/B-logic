class AddSolutionToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :solution, :string
  end
end
