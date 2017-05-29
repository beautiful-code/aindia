class Relationship < ApplicationRecord
  belongs_to :user_id, class_name: "User"
  belongs_to :interest_id, class_name: "SocialInterest"
  validates :user_id, presence: true
  validates :interest_id, presence: true
end
