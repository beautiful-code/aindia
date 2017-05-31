require 'rails_helper'

RSpec.describe User do
  let(:user) { FactoryGirl.create(:user) }
  let(:tempuser) { FactoryGirl.create(:user) }

  let(:socialinterest1) { FactoryGirl.create(:social_interest) }
  let(:socialinterest2) { FactoryGirl.create(:social_interest) }
  let(:socialinterest3) { FactoryGirl.create(:social_interest) }

  before do
    user.follow_interest(socialinterest2)

    OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
    '/auth/facebook'
  end

  it "should return false if name is not present" do
    expect(user.name).not_to be_nil
  end

  it "should return true if email is present" do
    expect(user.email).not_to be_nil
  end

  it "associated causes should be destroyed on deletion" do
    # Issue.create!(title: "Title", content: "Content")
    # tempuser.save
    # causes = tempuser.issues
    # tempuser.destroy
    # expect(causes.count).to be==0
  end

  it "sets a session variable to the OmniAuth auth hash" do
    byebug
    # expect(session['uid']).to equal('12345')
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
