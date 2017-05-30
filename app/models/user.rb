class User < ApplicationRecord
  has_many :issues, dependent: :destroy
  has_and_belongs_to_many :socialinterests, class_name: "SocialInterest"

  # has_many :passive_relationships, class_name:  "Relationship",
  #                                  foreign_key: "interest_id",
  #                                  dependent:   :destroy
  # has_many :following, through: :passive_relationships, source: :interest_id
  #
  # TODO: habtm :interests


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

  def follow_interest(social_interest)
    socialinterests << social_interest
  end

  def unfollow_interest(social_interest)
    socialinterests.delete(social_interest)
  end

  def is_following?(social_interest)
    socialinterests.include?(social_interest)
  end
end
