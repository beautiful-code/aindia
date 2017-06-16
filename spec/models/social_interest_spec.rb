require 'rails_helper'

RSpec.describe SocialInterest do
  let(:user) { FactoryGirl.create(:user) }

  let(:socialinterest1) { FactoryGirl.create(:social_interest) }
  let(:socialinterest2) { FactoryGirl.create(:social_interest) }

  before do
    user.follow_interest(socialinterest2)
  end

  it "should return false if title is not present" do
    expect(socialinterest1.title).not_to be_nil
  end

  it "should increment the followers count by 1 if user follows an interest" do
    byebug
    cnt = socialinterest2.users.count
    user.follow_interest(socialinterest2)
    expect(socialinterest2.users.count).to be == cnt + 1
  end

  it "should return true if number of followers are zero" do
    expect(socialinterest1.users.count).to be == 0
  end

  describe :is_following? do
    it "should return true if user follows the interest" do
      expect(user.is_following? socialinterest2).to be_truthy
    end

    it "should return true if user doesn't follow the interest" do
      expect(user.is_following? socialinterest1).to be_falsey
    end

  end
end
