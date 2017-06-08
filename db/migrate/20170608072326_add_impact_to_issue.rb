class AddImpactToIssue < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :impact, :string
  end
end
