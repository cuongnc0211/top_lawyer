FactoryBot.define do
  factory :law_firm do
    name {Faker::Name.name}
    province factory: :province
    phone_number { "1234567890" }
    email {Faker::Internet.email}
    address {Faker::Name.name}
    introduction {Faker::Name.name}
  end
end
