# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pswd = "supersecret"

User.create!(email: "alec.rodic@gmail.com", password: pswd, 
             password_confirmation: pswd)

49.times do |n|
  User.create!(email: Faker::Internet.email, password: pswd, 
               password_confirmation: pswd)
end

100.times do |n|
  creator_id = 1+rand(50)
  creator = User.find(creator_id)
  creator.events.create!(title: Faker::Lorem.sentence, 
                         description: Faker::Lorem.paragraph,
                         location: Faker::Address.street_address,
                         date: Faker::Date.between(3.week.ago, 5.week.from_now))
  
  attendees_ids = [ creator_id ]
  rand(15).times do |n|
    attendee_id = 1+rand(50)
    unless attendees_ids.include?(attendee_id)
      attendees_ids << attendee_id
      creator.events.last.attendees << User.find(attendee_id)
    end 
  end
end
