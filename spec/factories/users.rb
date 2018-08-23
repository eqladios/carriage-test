FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Lorem.word }, [6]
      username { Faker::Lorem.word }
    end
  end