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
    role: 1,
    is_active: true
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
    working_end_time: "17:00".to_time,
    is_active: true
end

puts "create_lawyer"
law_firm_ids = LawFirm.all.pluck :id
20.times do |n|
  account = Account.create(email: "lawyer#{n+1}@example.com",
    name: Faker::Name.name,
    password: "12345678",
    role: 2,
    is_active: true)
  account.create_lawyer_profile(point: Array(1..1000).sample,
    lawyer_id: Faker::Lorem.characters(10),
    address: Faker::Address.street_address,
    phone_number: Faker::PhoneNumber.cell_phone,
    is_active: true,
    is_manager: [0,1].sample,
    law_firm_id: law_firm_ids.sample,
    fax_number: Faker::PhoneNumber.phone_number,
    introduction: Faker::Lorem.paragraph,
    reputation: Array(1..100).sample)
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
    content: Faker::Lorem.paragraph(10, false, 4),
    category_id: category_ids.sample
end

puts "create_answer"
lawyer_account_ids = Account.Lawyer.pluck :id
question_ids = Question.all.pluck :id
40.times do |n|
  Answer.create account_id: lawyer_account_ids.sample,
    question_id: question_ids.sample,
    content: Faker::Lorem.paragraph(6, false, 4)
end

puts "create tag"
15.times do |n|
  Tag.create name: Faker::Job.field + "#{n}"
end

puts "create_article"
tags_name = Tag.all.pluck :name
50.times do |n|
  article = Article.create(account_id: lawyer_account_ids.sample,
    title: Faker::Lorem.sentence(3),
    content: Faker::Lorem.paragraph(50, false, 4),
    category_id: category_ids.sample,
    status: [0,1].sample,
    total_vote: Array(1..50).sample)

  article.tag_list.add(tags_name.sample, tags_name.sample, tags_name.sample)
  article.save
end

puts "create_point"
options = [:answer, :article, :vote_up, :vote_down, :advertise]
5.times do |n|
  Point.create option: options[n], point_per_time: n*10
end

puts "create_history_point"
point_ids = Point.all.pluck :id
50.times do |n|
  HistoryPoint.create account_id: lawyer_account_ids.sample, point_id: point_ids.sample,
    amount: [1,2,3,4].sample, total: [10,20,30,40].sample
end

puts "create_advertise"
history_point_ids = HistoryPoint.all.pluck(:id)
30.times do |n|
  HistoryAdvertise.create account_id: lawyer_account_ids.sample,
    category_id: category_ids.sample,
    province_id: province_ids.sample,
    history_point_id: history_point_ids.sample,
    start_time: [1,2,3,4,5].sample.days.ago,
    end_time: [0,1,2,3,4].sample.days.from_now
end
