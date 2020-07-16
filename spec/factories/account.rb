FactoryBot.define do
  factory :account do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password { "12345678" }
    password_confirmation { "12345678" }
    confirmed_at { Time.zone.now }
  end
end
