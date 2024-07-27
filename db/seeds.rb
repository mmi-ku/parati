# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.find_or_create_by!(email: "olivia@example.com") do |user|
#   user.name = "Olivia"
#   user.password = "password"
# end

# User.find_or_create_by!(email: "james@example.com") do |user|
#   user.name = "James"
#   user.password = "password"
# end
# Users = User.create (
#   [
#     {email: 'olivia@example.com', name: 'Olivia', password: 'password', password_confirmation: 'password'},
#     {email: 'james@example.com', name: 'James', password: 'password', password_confirmation: 'password'},
#     {email: 'lucas@example.com', name: 'Lucas', password: 'password', password_confirmation: 'password'},
#     {email: 'sarah@example.com', name: 'Sarah', password: 'password', password_confirmation: 'password'},
#     {email: 'jone@example.com', name: 'Jone', password: 'password', password_confirmation: 'password'}
#   ]
# )
user_data = [
  {email: 'olivia@example.com', name: 'Olivia', password: 'password', password_confirmation: 'password'},
  {email: 'james@example.com', name: 'James', password: 'password', password_confirmation: 'password'},
  {email: 'lucas@example.com', name: 'Lucas', password: 'password', password_confirmation: 'password'},
  {email: 'sarah@example.com', name: 'Sarah', password: 'password', password_confirmation: 'password'},
  {email: 'jone@example.com', name: 'Jone', password: 'password', password_confirmation: 'password'}
]

user_data.each do |data|
  User.find_or_create_by!(email: data[:email]) do |user|
    user.name = data[:name]
    user.password = data[:password]
    user.password_confirmation = data[:password_confirmation]
  end
end

User.all.each do |user|
  post = user.posts.build(
    title: 'Sample title',
    body: 'Sample text'
  )
  post.image.attach(
    io: File.open(Rails.root.join('db/images/no_image_square.jpg')),
    filename: 'no_image_square.jpg'
  )
  post.save!
end

# Genre.create (
#   [
#     {name: 'Jeans'},
#     {name: 'Blouse'},
#     {name: 'T-shirt'},
#     {name: 'Skirt'},
#     {name: 'Sweater'},
#     {name: 'Kimono'},
#     {name: 'Cardigan'},
#     {name: 'Knitwear'},
#     {name: 'Babysuits'},
#   ]
#   )
  genre_names = ['Jeans', 'Blouse', 'T-shirt', 'Skirt', 'Sweater', 'Kimono', 'Cardigan', 'Knitwear', 'Babysuits']
  genre_names.each do |genre_name|
  	Genre.find_or_create_by!(name: genre_name)
  end
  
  Admin.find_or_create_by!(email: "admin@admin") do |admin|
    admin.email = "admin@admin"
    admin.password = "testtest"
  end
  
#   Admin.create!(
#   email: 'admin@admin',
#   password: 'testtest'
# )
