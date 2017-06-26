require 'rails_helper'

RSpec.describe UsersHelper do
  let(:user) { FactoryGirl.create(:user) }

  before do
    user.image_url = 'sample_url'
  end

  describe :image_for do
    it 'should return image tag for user with image url' do
      expect(image_for(user)).not_to be_nil
    end
  end
end
