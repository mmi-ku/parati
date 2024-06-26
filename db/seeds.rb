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
Users = User.create!(
  [
    {email: 'olivia@example.com', name: 'Olivia', password: 'password', password_confirmation: 'password'},
    {email: 'james@example.com', name: 'James', password: 'password', password_confirmation: 'password'},
    {email: 'lucas@example.com', name: 'Lucas', password: 'password', password_confirmation: 'password'}
  ]
)

User.all.each do |user|
  post = user.posts.create!(
    title: 'Sample title',
    body: 'Sample text'
  )
  post.images.attach(io: File.open(Rails.root.join('db/images/no_image.jpeg')),
  filename: 'no_images.jpeg')
end

Genre.create!(
  [
    {name: 'Jeans'},
    {name: 'Blouse'},
    {name: 'T-shirt'},
    {name: 'Skirt'},
    {name: 'Sweater'},
    {name: 'Kimono'},
    {name: 'Cardigan'},
    {name: 'Knitwear'},
    {name: 'Babysuits'},
  ]
  )
