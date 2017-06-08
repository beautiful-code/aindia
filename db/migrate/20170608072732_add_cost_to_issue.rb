class AddCostToIssue < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :cost, :double
  end
end
