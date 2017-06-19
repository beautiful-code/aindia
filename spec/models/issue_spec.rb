require 'rails_helper'

RSpec.describe Issue do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user_with_causes) { FactoryGirl.create(:user_with_issues) }

  before do
    cause = user_with_causes.issues.first
    user2.support_issue(cause)
  end

  it "should be valid" do
    cause = user_with_causes.issues.first
    expect(cause.valid?).to be_truthy
  end

  it "user id should be present" do
    cause = user_with_causes.issues.first
    expect(cause.user.id).not_to be_nil
  end

  it "title should be present" do
    cause = user_with_causes.issues.first
    expect(cause.title).not_to be_nil
  end

  it "content or image should be present" do
    cause = user_with_causes.issues.first
    expect([cause.content, cause.imageurl]).not_to be_nil
  end

  it "should have non-zero supporting users for a cause" do
    cause = user_with_causes.issues.first
    expect(cause.get_supported_users_count).to equal(1)

    expect(cause.is_supported_by_user?(user2)).to be_truthy
  end

  it "causes order should be most recent first"
  # do
  #   causeslist = user_with_causes.issues
  #   cause1 = user_with_causes.issues.first
  #   cause2 = user_with_causes.issues.last
  #   # expect(most_recent(causeslist)).to equal(cause)
  # end

end
