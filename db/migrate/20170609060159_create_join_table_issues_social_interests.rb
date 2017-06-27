class CreateJoinTableIssuesSocialInterests < ActiveRecord::Migration[5.0]
  def change
    create_join_table :issues, :social_interests do |t|
      # t.index [:issue_id, :social_interest_id]
      # t.index [:social_interest_id, :issue_id]
    end

  end
end
