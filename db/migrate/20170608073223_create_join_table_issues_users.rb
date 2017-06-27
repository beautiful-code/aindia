class CreateJoinTableIssuesUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :issues, :users do |t|
      t.index [:issue_id, :user_id]
      t.index [:user_id, :issue_id]
    end
  end
end
