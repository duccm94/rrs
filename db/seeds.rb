# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "admin", email: "admin@gmail.com", password: "123456789",
  is_admin: true)
User.create(name: "phanbt", email: "phan@gmail.com", password: "123456",
  password_confirmation: "123456", is_admin: false)
Category.create(title: "Food")
Category.create(title: "Drink")
Category.create(title: "FastFood")
Category.create(title: "KFC")
