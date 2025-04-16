FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    published_at { nil }
    user
    organization { user&.organization || create(:organization) }

    trait :published do
      published_at { Time.current }
    end

    trait :draft do
      published_at { nil }
    end
  end
end
