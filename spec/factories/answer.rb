FactoryBot.define do
  factory :answer do
    account factory: :account
    question factory: :question
    content {Faker::Name.name}
  end
end
