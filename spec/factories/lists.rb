FactoryBot.define do
    factory :list do
      title { Faker::Lorem.characters(12) }
    end
end