# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "admin", email: "admin@gmail.com", password: "123456",
  is_admin: true)
User.create(name: "hatd", email: "hatd@gmail.com", password: "123456",
  password_confirmation: "123456", is_admin: false)
User.create(name: "hatd2", email: "hatd2@gmail.com", password: "123456",
  password_confirmation: "123456", is_admin: false)
(1..10).each do |n|
  User.create(name: Faker::Name.name, email: "user#{n}@gmail.com", password: "123456",
    password_confirmation: "123456", is_admin: false)
end


Category.create(title: "Food")
Category.create(title: "Drink")
Category.create(title: "FastFood")
Category.create(title: "KFC")
a = 1
(1..5).each do |m|
  (1..4).each do |n|
    a = a + 1
    book = Book.create!(category_id: n, title: Faker::Company.name,
      description: Faker::Lorem.paragraph(2, true),
      author: Faker::Address.street_address + "," + Faker::Address.city,
      rate_score: Faker::Number.between(1, 5),
      image: File.open("app/assets/images/#{a}.jpg"))
  end
end

(4..13).each do |n|
  (1..20).each do |m|
    Review.create!(book_id: m, content: Faker::Lorem.paragraph(2, true),
      rating: Faker::Number.between(1, 5), user_id: n)
  end
end
