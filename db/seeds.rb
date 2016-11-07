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
User.create(name: "congchinh", email: "congchinh@gmail.com", password: "123456",
  password_confirmation: "123456", is_admin: false)

Category.create(title: "Food")
Category.create(title: "Drink")
Category.create(title: "FastFood")
Category.create(title: "KFC")

Book.create!(category_id: 1,title: "Hai Xom", author: "so 1 truong chinh, ha noi")
Book.create!(category_id: 2,title: "Tra da", author: "so 123/3 tran khat chan, ha noi")
Book.create!(category_id: 3,title: "BBQ", author: "ngach 32/4 truong chinh, ha noi")
Book.create!(category_id: 4,title: "Japan Food", author: "23 ta quang buu, ha noi")
Book.create!(category_id: 1,title: "Milkca", author: " truong chinh, ha noi")
Book.create!(category_id: 2,title: "Mamamy", author: "4444 dai co viet, ha noi")
Book.create!(category_id: 3,title: "Citygo", author: "434 tran khat chan, ha noi")

Review.create!(book_id: 1, content: "quan nay do an ngon", rating: 4, user_id: 2)
Review.create!(book_id: 2, content: "quan nay an tam", rating: 3, user_id: 3)
Review.create!(book_id: 3, content: "khong ngon", rating: 2, user_id: 3)
Review.create!(book_id: 4, content: "an khong ngon teo nao", rating: 1, user_id: 2)
Review.create!(book_id: 5, content: "qua la ngon", rating: 5, user_id: 3)
Review.create!(book_id: 6, content: "vua dat vua khong ngon lai con ban", rating: 1, user_id: 2)
Review.create!(book_id: 7, content: "ngon bo re", rating: 4, user_id: 2)
