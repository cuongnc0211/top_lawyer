FactoryBot.define do
  factory :article do
    title {Faker::Lorem.paragraph}
    content {Faker::Lorem.paragraph}
  end
end
