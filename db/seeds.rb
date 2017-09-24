# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  email = Faker::Internet.email
  name = Faker::Name.name
  password = "password"
  User.create!(email: email,
               name: name,
               password: password,
               password_confirmation: password
               )
end

n = 1
while n <= 100
  title = Faker::Coffee.blend_name
  content = Faker::Coffee.origin
  Blog.create!(
    title: title,
    content: content,
    user_id: n
  )
  n = n + 1
end
