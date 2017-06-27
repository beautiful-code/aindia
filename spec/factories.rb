# frozen_string_literal: true

FactoryGirl.define do
  factory :issue do
    title Faker::Name.name
    content Faker::Lorem.characters(20)
  end

  factory :social_interest do
    title Faker::Name.name
    description Faker::Lorem.characters(30)
  end

  # factory :user do
  #   name Faker::Name.name
  #   email Faker::Internet.email
  #   gender "Male"
  # end

  # user factory without associated issues
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    oauth_token Faker::Lorem.characters(30)
    gender 'Male'

    factory :user_with_issues do
      transient do
        issues_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:issue, evaluator.issues_count, user: user)
      end
    end
  end
end
