# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user
  # TODO: belongs_to :leader, :class_name => "User"

  default_scope -> { order(created_at: :desc) }
  mount_uploader :imageurl, PictureUploader

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 20_000 }

  has_and_belongs_to_many :social_interests, class_name: 'SocialInterest'
  has_and_belongs_to_many :supported_users, class_name: 'User'

  def supported_by_user?(suser)
    supported_users.include?(suser)
  end

  def supported_users_count
    supported_users.count
  end
end



