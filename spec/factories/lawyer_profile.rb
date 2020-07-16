FactoryBot.define do
  factory :lawyer_profile do
    account factory: :account
    law_firm factory: :law_firm
    phone_number { "1234567890" }
    fax_number {Faker::Internet.email}
    address {Faker::Name.name}
    introduction {Faker::Name.name}
    lawyer_id { "123123123" }
    is_active { true }
    approved { true }
  end
end
