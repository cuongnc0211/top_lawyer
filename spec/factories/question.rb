FactoryBot.define do
  factory :question do
    title { "test" }
    account factory: :account
    category factory: :category
    content {Faker::Name.name}
  end
end
