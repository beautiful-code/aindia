require 'rails_helper'

RSpec.describe User do
  let(:user) { FactoryGirl.create(:user) }
  let(:tempuser) { FactoryGirl.create(:user) }

  let(:socialinterest1) { FactoryGirl.create(:social_interest) }
  let(:socialinterest2) { FactoryGirl.create(:social_interest) }
  let(:socialinterest3) { FactoryGirl.create(:social_interest) }

  before do
    user.follow_interest(socialinterest2)
  end

  [:name, :email, :oauth_token].each do |field|
    it "should return error if #{field} is nil" do
      user.send("#{field}=".to_sym,nil)
      expect(user.valid?).to be_falsey
    end
  end

  # describe :update_uid do
  #   before do
  #     OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  #       provider: 'facebook',
  #       info: {
  #         name: 'first last',
  #         email: 'test@gmail.com'
  #       },
  #       uid: '123456',
  #       credentials: {
  #         token: 'token',
  #         expires_at: Time.now + 1.week
  #       }
  #     })
  #   end
  #
  #   it 'test update ' do
  #     auth = {}
  #     info ={}
  #     allow(auth).to receive(:info).and_return(info)
  #     user.update_uid(auth)
  #     expect(user.uid).to eq(23)
  #   end
  # end



  describe :from_omniauth do
    before do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: 'facebook',
        info: {
          name: 'first last',
          email: 'test@gmail.com'
        },
        uid: '12345',
        credentials: {
          token: 'token',
          expires_at: Time.now + 1.week
        }
      })
    end

    it 'should check user validity' do
      user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      expect(user.valid?).to be_truthy
    end

    it 'should get all the user details from omniauth for successful authentication' do
      user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      expect(user.name).to eq('first last')
      expect(user.email).to eq('test@gmail.com')
    end
 end

describe :destroy do
  it "associated causes should be destroyed on deletion" do
    user.issues.create(title: "RANDOM", content: "RANDOM")
    expect(socialinterest2.user_ids.include?(user.id)).to be_truthy

 byebug
    expect { user.destroy }.to change { User.count }.by(
      -1
    ).and change { Issue.count }.by(-1)

    socialinterest2.reload

    expect(socialinterest2.user_ids.include?(user.id)).to be_falsey
  end
end

  describe :follow_interest do
    it "should allow user to follow the interest" do
      user.follow_interest(socialinterest3)
      expect(user.is_following?(socialinterest3)).to be_truthy
    end
  end

  describe :unfollow_interest do
    it "should allow user to unfollow the interest" do
      user.follow_interest(socialinterest3)
      user.unfollow_interest(socialinterest3)
      expect(user.is_following?(socialinterest3)).to be_falsey
    end
  end

  describe :is_following? do
    it "should return true if user follows the interest" do
      expect(user.is_following? socialinterest2).to be_truthy
    end

    it "should return false if user doesn't follow the interest" do
      expect(user.is_following? socialinterest1).to be_falsey
    end
  end
end
