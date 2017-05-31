FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    gender "Male"
  end

  factory :issue do
    title Faker::Name.name
    content Faker::Lorem.characters(20)
  end

  factory :social_interest do
    title Faker::Name.name
    description Faker::Lorem.characters(30)
  end
end
