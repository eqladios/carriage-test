FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Lorem.characters(6) }
      username { Faker::Lorem.word }
    end
  end