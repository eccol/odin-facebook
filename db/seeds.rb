# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

10.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "123456"
  )
  user.build_profile(
    name: Faker::Name.name,
    birthday: Faker::Date.between(from: 60.years.ago, to: 18.years.ago),
    city: Faker::Address.city
  )
  user.save
end