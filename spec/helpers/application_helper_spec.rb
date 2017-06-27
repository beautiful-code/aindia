require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe :full_title do
    it 'should return a valid and expected title' do
      expect(full_title('test')).to eq('test | Social Quora')
      expect(full_title('')).to eq('Social Quora')
    end
  end
end
