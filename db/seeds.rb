# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Golfer.create!(name:                  "Clarence Bishop",
               email:                 "clarencebishop@yahoo.com",
               password:              "password",
               password_confirmation: "password",
               admin: true,
               activated: true,
               activated_at: Time.zone.now)

Golfer.create!(name:                  "Clyde Bishop",
               email:                 "clydebishop@hp.com",
               password:              "password",
               password_confirmation: "password",
               admin: false,
               activated: true,
               activated_at: Time.zone.now)


10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  Golfer.create!(name:                  name,
                 email:                 email,
                 password:              password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
end

Course.create!(name:      "Frisco Lakes",
               par:       72,
               par_data: "5 4 3 4 4 3 5 4 5 5 3 4 4 3 4 3 4 5")

Course.create!(name:      "The Tribute",
               par:       72,
               par_data: "5 4 3 4 4 3 4 4 5 5 3 4 4 4 4 3 4 5")

Course.create!(name:      "Watters Creek",
               par:       72,
               par_data: "4 4 3 5 4 3 4 4 5 4 3 4 4 5 4 3 4 5")

Course.create!(name:      "Trails of Frisco",
               par:       71,
               par_data: "5 4 3 4 4 3 4 4 5 5 3 4 4 3 4 3 4 5")

Course.create!(name:      "Pecan Hollow",
               par:       71,
               par_data: "5 4 3 4 4 3 5 4 5 4 3 4 4 3 4 3 4 5")

Course.create!(name:      "Firewheel",
               par:       72,
               par_data: "5 4 3 5 4 3 5 4 5 4 3 4 4 3 4 3 4 5")
