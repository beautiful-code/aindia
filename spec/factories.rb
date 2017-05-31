FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    gender "Male"
  end

  factory :social_interest do
    title Faker::Name.name
    description Faker::Lorem.characters(30)
  end
end
