require 'rails_helper'

RSpec.describe Issue do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_with_causes) { FactoryGirl.create(:user_with_issues) }

  before do
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

  it "causes order should be most recent first"
  # do
    # causes = user_with_causes.issues
    # cause = user_with_causes.issues.first
    # expect(causes(:most_recent)).to be_equal(cause)
  # end

end
