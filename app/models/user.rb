class User < ApplicationRecord
  has_many :issues, dependent: :destroy # created issues
  has_and_belongs_to_many :socialinterests, class_name: "SocialInterest"
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

  def follow_interest(social_interest)
    socialinterests << social_interest
  end

  def unfollow_interest(social_interest)
    socialinterests.delete(social_interest)
  end

  def is_following?(social_interest)
    socialinterests.include?(social_interest)
  end

  def support_issue(issue)
    if self.is_supporting?(issue)
      supported_issues.delete(issue)
    else
      supported_issues << issue
    end
  end

  def is_supporting?(issue)
    supported_issues.include?(issue)
  end

  def get_support_button_text(issue)
    s = 'Support'
    if self.is_supporting?(issue)
      s = 'Unsupport'
    else
      s = 'Support'
    end
  end
end
