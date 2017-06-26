# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user_with_causes) { FactoryGirl.create(:user_with_issues) }

  %i[user_id title content].each do |field|
    it 'should return error if #{field} is nil' do
      cause = user_with_causes.issues.last
      cause.send("#{field}=".to_sym, nil)
      expect(cause.valid?).to equal(false)
    end
  end

  it 'should be valid' do
    cause = user_with_causes.issues.first
    expect(cause.valid?).to equal(true)
  end

  it 'should be invalid if content is more than 20,000 chars' do
    cause = user_with_causes.issues.last
    cause.content = Faker::Lorem.characters(20_001)
    expect(cause.valid?).to equal(false)
  end

  it 'user id should be present' do
    cause = user_with_causes.issues.first
    expect(cause.user.id).not_to be_nil
  end

  it 'title should be present' do
    cause = user_with_causes.issues.first
    expect(cause.title).not_to be_nil
  end

  describe :supported_by_user? do
    it 'should have non-zero supporting users for a cause' do
      cause = user_with_causes.issues.first
      user2.support_issue(cause)
      expect(cause.supported_by_user?(user2)).to equal(true)
    end
  end

  describe :supported_users_count do
    it 'should match the count of supported users to that of expected' do
      cause = user_with_causes.issues.first
      user2.support_issue(cause)
      count = cause.supported_users_count
      expect(count).to equal(1)
    end
  end
end
