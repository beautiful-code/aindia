class User < ApplicationRecord
  has_many :issues, dependent: :destroy


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

private
def user_params
  params.require(:user).permit(:name, :uid, :provider, :oauth_token, :oauth_expires_at, :email, :image_url)
end

end
