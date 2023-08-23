# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

User.destroy_all
User.create!(email: "test@gmail.com",
             password: "azerty",
             password_confirmation: "azerty",
             first_name: "test",
             last_name: "test",
             username: "azerty",
             avatar: "https://dessins-animes-hrd.appspot.com/img/dessins-animes/davidlegnome.jpg")
20.times do
  password = Faker::Internet.password
  User.create!(email: Faker::Internet.email,
               password: password,
               password_confirmation: password,
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               username: Faker::Internet.username(specifier: 6..10),
               avatar: "https://dessins-animes-hrd.appspot.com/img/dessins-animes/davidlegnome.jpg")
end

Castle.destroy_all
20.times do
  Castle.create!(user: User.all.sample,
                 name: Faker::Name.name,
                 price: Faker::Commerce.price,
                 address: Faker::Address.full_address,
                 description: Faker::Movie.quote)
end

Booking.destroy_all
today = Date.today
10.times do
  begin_date = (today..(today + 30.days)).to_a.sample
  end_date = ((begin_date + 1.days)..((begin_date + 1.days) + 30.days)).to_a.sample
  Booking.create!(date_begin: begin_date,
                  date_end: end_date,
                  user: User.all.sample,
                  castle: Castle.all.sample)
end
