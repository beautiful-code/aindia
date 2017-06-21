# frozen_string_literal: true

class User < ApplicationRecord
  has_many :issues, dependent: :destroy # created issues
  has_and_belongs_to_many :social_interests, class_name: "SocialInterest"
  validates :name, presence: true
  validates :email, presence: true
  validates :oauth_token, presence: true
  has_and_belongs_to_many :supported_issues, class_name: "Issue" # supported issues

  def self.from_omniauth(auth)
    #where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|

      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.image_url = auth.info.image
      user.email = auth.info.email
      user.save!
    end
  end

  # def update_uid(auth)
  #   self.uid = auth.uid
  #   save
  # end


  # Following Interests methods
  def is_following?(social_interest)
    social_interests.include?(social_interest)
  end

  def update_follow_interests(social_interest)
    if is_following?(social_interest)
      unfollow_interest(social_interest)
    else
      follow_interest(social_interest)
    end
  end

  def follow_interest(social_interest)
    social_interests << social_interest
  end

  def unfollow_interest(social_interest)
    social_interests.delete(social_interest)
  end

  # Support Issue methods

  def is_supporting?(issue)
    supported_issues.include?(issue)
  end

  def update_support_issue(issue)
    if self.is_supporting?(issue)
      unsupport_issue(issue)
    else
      support_issue(issue)
    end
  end

  def support_issue(issue)
    supported_issues << issue
  end

  def unsupport_issue(issue)
    supported_issues.delete(issue)
  end

  def get_issues_based_on_my_interests
    if social_interests.count > 0
      feed_items = Issue.includes(:social_interests).where(social_interests: { id: social_interests.pluck(:id) })
    else
      feed_items = Issue.all
    end
  end
end
