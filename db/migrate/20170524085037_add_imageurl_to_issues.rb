class AddImageurlToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :imageurl, :string
  end
end
