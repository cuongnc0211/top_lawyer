puts "create_admin"
10.times do |n|
  Account.create email: "admin#{n + 1}@example.com",
    name: "admin#{n+1}",
    password: "12345678",
    role: 0
end

puts "create_user"
20.times do |n|
  Account.create email: "user#{n+1}@example.com",
    name: Faker::Name.name,
    password: "12345678",
    role: 1
end

puts "create_province"

10.times do |n|
  Province.create name: Faker::Address.city
end

puts "create law_firm"
province_ids = Province.all.pluck :id
10.times do |n|
  LawFirm.create name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.street_address,
    fax: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email,
    introduction: Faker::Lorem.paragraph,
    province_id: province_ids.sample,
    working_start_time: "08:00".to_time,
    working_end_time: "17:00".to_time
end

puts "create_lawyer"
law_firm_ids = LawFirm.all.pluck :id
20.times do |n|
  account = Account.create(email: "lawyer#{n+1}@example.com",
    name: Faker::Name.name,
    password: "12345678",
    role: 2)
  account.create_lawyer_profile(point: Array(1..1000).sample,
    lawyer_id: Faker::Lorem.characters(10),
    address: Faker::Address.street_address,
    phone_number: Faker::PhoneNumber.cell_phone,
    is_active: true,
    is_manager: [0,1].sample,
    law_firm_id: law_firm_ids.sample,
    fax_number: Faker::PhoneNumber.phone_number,
    introduction: Faker::Lorem.paragraph,
    reputation: Array(1..100).sample,
    point: Array(1..100).sample,
    advertise_start_time: Array(1..10).sample.days.ago,
    advertise_start_time: Array(0..10).sample.days.after)
end

puts "create_education"
lawyer_profile_ids = LawyerProfile.all.pluck :id
30.times do |n|
  Education.create lawyer_profile_id: lawyer_profile_ids.sample,
    degree: [:bachelor, :master, :doctor].sample,
    school: Faker::Educator.university
end

puts "create_category"
13.times do |n|
  Category.create name: Faker::Lorem.word
end

puts "create_question"
user_ids = Account.User.all.pluck :id
category_ids = Category.all.pluck :id
50.times do |n|
  Question.create account_id: user_ids.sample,
    title: Faker::Lorem.sentence(3),
    content: Faker::Lorem.paragraph(2),
    category_id: category_ids.sample
end

puts "create_article"
50.times do |n|
  Article.create account_id: user_ids.sample,
    title: Faker::Lorem.sentence(3),
    content: Faker::Lorem.paragraph(2),
    category_id: category_ids.sample,
    status: [0,1].sample,
    total_vote: Array(1..50).sample
end

