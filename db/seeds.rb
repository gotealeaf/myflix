# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Category.create(name: 'Comedy')
# Category.create(name: 'Drama')
# Category.create(name: 'Action')

Review.create(video_id: 1, user_id: 1, rating: rand(1..5), description: Faker::Lorem.paragraph.to_s)
Review.create(video_id: 1, user_id: 1, rating: rand(1..5), description: Faker::Lorem.paragraph.to_s)
Review.create(video_id: 1, user_id: 1, rating: rand(1..5), description: Faker::Lorem.paragraph.to_s)
Review.create(video_id: 1, user_id: 1, rating: rand(1..5), description: Faker::Lorem.paragraph.to_s)