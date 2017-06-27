# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { FactoryGirl.create(:user) }
  let(:tempuser) { FactoryGirl.create(:user) }
  let(:user_with_causes) { FactoryGirl.create(:user_with_issues) }

  let(:socialinterest1) { FactoryGirl.create(:social_interest) }
  let(:socialinterest2) { FactoryGirl.create(:social_interest) }
  let(:socialinterest3) { FactoryGirl.create(:social_interest) }

  before do
    user.update_follow_interests(socialinterest2)
  end

  %i[name email oauth_token].each do |field|
    it 'should return error if #{field} is nil' do
    # TODO: it 'should return error if #{field} is not present' do
      user.send("#{field}=".to_sym, nil)
      expect(user.valid?).to be_falsey
    end
  end

  describe :from_omniauth do
    before do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        info: {
          name: 'first last',
          email: 'test@gmail.com'
        },
        uid: '12345',
        credentials: {
          token: 'token',
          expires_at: Time.zone.now + 1.week
        }
      )
    end

    it 'should check user validity' do
      user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      expect(user.valid?).to be_truthy
    end

    it 'should get all the user details from omniauth for successful
      authentication' do
      user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      expect(user.name).to eq('first last')
      expect(user.email).to eq('test@gmail.com')
    end
  end

  # TODO: it 'should delete all the associated causes on deletion' do
  it 'associated causes should be destroyed on deletion' do
    count = user_with_causes.issues.count
    total_count = Issue.all.count
    user_with_causes.destroy
    expect(Issue.all.count).to equal(total_count - count)
  end

  describe :follow_interest do
    it 'should allow user to follow the interest' do
      user.follow_interest(socialinterest3)
      expect(user.following?(socialinterest3)).to be_truthy
    end

    it 'should not do anything if the user is already following the interest'
  end

  describe :unfollow_interest do
    # TODO: Expose unfollow_interest as public.
    it 'should allow user to unfollow the interest' do
      user.follow_interest(socialinterest3)
      user.update_follow_interests(socialinterest3)
      expect(user.following?(socialinterest3)).to be_falsey
    end
  end

  describe :following? do
    it 'should return true if user follows the interest' do
      # TODO: user.follow_interest(socialinterest2)
      expect(user.following?(socialinterest2)).to be_truthy
    end

    it 'should return false if user doesn\'t follow the interest' do
      expect(user.following?(socialinterest1)).to be_falsey
    end
  end

  # TODO: This raises a flag on your names.
  describe :support_issue do
    it 'should allow the user to support the issue' do
      cause = user_with_causes.issues.first
      user.update_support_issue(cause)
      expect(user.supporting?(cause)).to equal(true)
    end
  end

  # TODO: This raises a flag on your names.
  describe :unsupport_issue do
    it 'should allow user to unsupport the issue' do
      cause = user_with_causes.issues.first
      user.support_issue(cause)
      user.update_support_issue(cause)
      expect(user.supporting?(cause)).to equal(false)
    end
  end

  describe :supporting? do
    it 'should return true if user supports the issue' do
      cause = user_with_causes.issues.first
      user.support_issue(cause)
      expect(user.supporting?(cause)).to equal(true)
    end

    it 'should return false if user doesn\'t support the issue' do
      cause = user_with_causes.issues.first
      expect(user.supporting?(cause)).to equal(false)
    end
  end

  describe :issues_based_on_my_interests do
    it 'should return all the causes in the system if user is not following
        any interests' do
      count = user_with_causes.issues.count
      expect(tempuser.issues_based_on_my_interests.count).to be_equal(count)
    end

    it 'should return only causes with the users social interest if following
        any social interest' do
      tempuser.follow_interest(socialinterest1)
      count = socialinterest1.issues.count
      expect(tempuser.issues_based_on_my_interests.count).to be_equal(count)

      # Object comparison is the ideal logic here.
    end

=begin
    it 'should return only causes relevent to the users si sorted by their creation date' do
      tempuser.follow_interest(socialinterest1)
      tempuser.follow_interest(socialinterest2)

      issues1 = socialinterest1.issues
      issues2 = socialinterest2.issues

      expect(tempuser.issues_based_on_my_interests).should == (issues1 + issues2).uniq.sort_by(:created_at)
    end
=end


  end
end
