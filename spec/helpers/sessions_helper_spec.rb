require 'rails_helper'

RSpec.describe SessionsHelper do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  before do
    log_in(user)
  end

  describe :logged_in? do
    it 'should return true if a user is logged in' do
      expect(logged_in?).to equal(true)
    end
  end

  describe :current_user? do
    it 'should return false if current logged in user is different' do
      expect(current_user?(user2)).to equal(false)
    end
  end

  describe :logout do
    before do
      log_out
    end

    it 'should return nil for current user' do
      expect(current_user).to be_nil
    end
  end
end
