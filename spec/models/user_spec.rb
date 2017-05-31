require 'rails_helper'

RSpec.describe User do
  let(:user) { FactoryGirl.create(:user) }

  let(:socialinterest1) { FactoryGirl.create(:social_interest) }
  let(:socialinterest2) { FactoryGirl.create(:social_interest) }
  let(:socialinterest3) { FactoryGirl.create(:social_interest) }

  before do
    user.follow_interest(socialinterest2)
  end

  describe :is_following? do
    it "should return true if user follows the interest" do
      expect(user.is_following? socialinterest2).to be_falsey
    end

    it "should return false if user doesn't follow the interest"
  end
end
