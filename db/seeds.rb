require "csv"

puts "create_admin"
2.times do |n|
  Account.create email: "admin#{n + 1}@example.com",
    name: "admin#{n + 1}",
    password: "12345678",
    role: 0,
    confirmed_at: Time.zone.now
end

puts "create_user"
10.times do |n|
  Account.create email: "user#{n + 1}@example.com",
    name: Faker::Name.name,
    password: "12345678",
    role: 1,
    is_active: true,
    confirmed_at: Time.zone.now
end

puts "create_province"
CSV.foreach(Rails.root.join("db/master/provinces.csv"), headers: true) do |row|
  Province.create name: row.to_s
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
  account = Account.create(email: "lawyer#{n + 1}@example.com",
                           name: Faker::Name.name,
                           password: "12345678",
                           role: 2,
                           is_active: true,
                           confirmed_at: Time.zone.now)
  account.create_lawyer_profile(point: Array(1..1000).sample,
                                lawyer_id: Faker::Lorem.characters(10),
                                address: Faker::Address.street_address,
                                phone_number: Faker::PhoneNumber.cell_phone,
                                approved: true,
                                is_active: true,
                                is_manager: [0, 1].sample,
                                law_firm_id: law_firm_ids.sample,
                                fax_number: Faker::PhoneNumber.phone_number,
                                introduction: Faker::Lorem.paragraph,
                                reputation: Array(1..100).sample)
end

puts "create_universities"
CSV.foreach(Rails.root.join("db/master/universities.csv"), headers: true) do |row|
  University.create name: row.to_s
end
university_ids = University.all.pluck :id

puts "create_education"
lawyer_profile_ids = LawyerProfile.all.pluck :id
30.times do |n|
  Education.create lawyer_profile_id: lawyer_profile_ids.sample,
    degree: [:bachelor, :master, :doctor].sample,
    university_id: university_ids.sample
end

puts "create_category"
CSV.foreach(Rails.root.join("db/master/categories.csv"), headers: true) do |row|
  Category.create name: row.to_s
end

puts "create tag"
CSV.foreach(Rails.root.join("db/master/tags.csv"), headers: true) do |row|
  Tag.create name: row.to_s
end
tags_name = Tag.all.pluck :name

puts "create_question"
user_ids = Account.User.all.pluck :id
category_ids = Category.all.pluck :id
50.times do |n|
  question = Question.create(account_id: user_ids.sample,
                             title: Faker::Lorem.sentence(3),
                             content: Faker::Lorem.paragraph(10, false, 4),
                             category_id: category_ids.sample)
  question.tag_list.add(tags_name.sample, tags_name.sample, tags_name.sample)
  question.save
end

puts "create_answer"
lawyer_account_ids = Account.Lawyer.pluck :id
question_ids = Question.all.pluck :id
40.times do |n|
  Answer.create account_id: lawyer_account_ids.sample,
    question_id: question_ids.sample,
    content: Faker::Lorem.paragraph(6, false, 4)
end

puts "create_article"
50.times do |n|
  article = Article.create(account_id: lawyer_account_ids.sample,
                           title: Faker::Lorem.sentence(3),
                           content: Faker::Lorem.paragraph(50, false, 4),
                           category_id: category_ids.sample,
                           status: [0, 1].sample,
                           total_vote: Array(1..50).sample)

  article.tag_list.add(tags_name.sample, tags_name.sample, tags_name.sample)
  article.save
end

puts "create_point"
options = [:answer, :article, :vote_up, :vote_down, :advertise]
5.times do |n|
  Point.create option: options[n], point_per_time: n * 10
end

puts "create_history_point"
point_ids = Point.all.pluck :id
50.times do |n|
  HistoryPoint.create account_id: lawyer_account_ids.sample, point_id: point_ids.sample,
    amount: [1, 2, 3, 4].sample, total: [10, 20, 30, 40].sample
end

puts "create_advertise"
history_point_ids = HistoryPoint.all.pluck(:id)
30.times do |n|
  HistoryAdvertise.create account_id: lawyer_account_ids.sample,
    category_id: category_ids.sample,
    province_id: province_ids.sample,
    history_point_id: history_point_ids.sample,
    start_time: [1, 2, 3, 4, 5].sample.days.ago,
    end_time: [0, 1, 2, 3, 4].sample.days.from_now
end
