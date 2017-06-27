# frozen_string_literal: true

class SocialInterest < ApplicationRecord
  validates :title, presence: true
  has_and_belongs_to_many :users
  has_and_belongs_to_many :issues
end
