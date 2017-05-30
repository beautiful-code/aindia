class CreateJoinTableSocialInterestUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :social_interests, :users do |t|
      t.index [:social_interest_id, :user_id]
      # t.index [:user_id, :social_interest_id]
    end
  end
end
