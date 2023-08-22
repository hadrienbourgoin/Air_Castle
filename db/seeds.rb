# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
User.destroy_all
20.times do
  password = Faker::Internet.password
  User.create(email: Faker::Internet.email,
              password: password,
              password_confirmation: password,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              username: Faker::Internet.username(specifier: 6..10))
end
Castle.destroy_all
20.times do
  
  Castle.create(
    user: User.all.sample,
    name: Faker::Name.name,
              price: Faker::Commerce.price,
              address: Faker::Address.full_address,
              description: Faker::Movie.quote,
              photo: "https://a.cdn-hotels.com/gdcs/production12/d1130/83f1c8c6-e12d-4e69-8433-c5bbc90b5ad6.jpg")
end
