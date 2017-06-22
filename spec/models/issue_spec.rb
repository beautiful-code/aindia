# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user_with_causes) { FactoryGirl.create(:user_with_issues) }

  %i[user_id title content].each do |field|
    it 'should return error if #{field} is nil' do
      issue = user_with_causes.issues.last
      issue.send("#{field}=".to_sym, nil)
      expect(issue.valid?).to be_falsey
    end
  end

  it 'should be valid' do
    cause = user_with_causes.issues.first
    expect(cause.valid?).to be_truthy
  end

  it 'should be invalid if content is more than 20,000 chars' do
    cause = user_with_causes.issues.last
    cause.content = Faker::Lorem.characters(20001)
    expect(cause.valid?).to be_falsey
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
    before do
      cause = user_with_causes.issues.first
      user2.support_issue(cause)
    end

    it 'should have non-zero supporting users for a cause' do
      cause = user_with_causes.issues.first
      expect(cause.supported_users_count).to equal(1)

      expect(cause.supported_by_user?(user2)).to be_truthy
    end
  end
end
