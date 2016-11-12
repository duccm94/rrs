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

Category.create(title: "Food")
Category.create(title: "Drink")
Category.create(title: "FastFood")
Category.create(title: "KFC")

Book.create!(category_id: 1,title: "Hai Xom", description: Faker::Lorem.paragraph(2, true),
  author: "so 1 truong chinh, ha noi")
Book.create!(category_id: 2,title: "Tra da", description: Faker::Lorem.paragraph(2, true),
  author: "so 123/3 tran khat chan, ha noi")
Book.create!(category_id: 3,title: "BBQ", description: Faker::Lorem.paragraph(2, true),
  author: "ngach 32/4 truong chinh, ha noi")
Book.create!(category_id: 4,title: "Japan Food", description: Faker::Lorem.paragraph(2, true),
  author: "23 ta quang buu, ha noi")
Book.create!(category_id: 1,title: "Milkca", description: Faker::Lorem.paragraph(2, true),
  author: " truong chinh, ha noi")
Book.create!(category_id: 2,title: "Mamamy", description: Faker::Lorem.paragraph(2, true),
  author: "4444 dai co viet, ha noi")
Book.create!(category_id: 3,title: "Citygo", description: Faker::Lorem.paragraph(2, true),
  author: "434 tran khat chan, ha noi")

Review.create!(book_id: 1, content: Faker::Lorem.paragraph(2, true), rating: 4, user_id: 2)
Review.create!(book_id: 2, content: Faker::Lorem.paragraph(2, true), rating: 3, user_id: 3)
Review.create!(book_id: 3, content: Faker::Lorem.paragraph(2, true), rating: 2, user_id: 3)
Review.create!(book_id: 4, content: Faker::Lorem.paragraph(2, true), rating: 1, user_id: 2)
Review.create!(book_id: 5, content: Faker::Lorem.paragraph(2, true), rating: 5, user_id: 3)
Review.create!(book_id: 6, content: Faker::Lorem.paragraph(2, true), rating: 1, user_id: 2)
Review.create!(book_id: 7, content: Faker::Lorem.paragraph(2, true), rating: 4, user_id: 2)
