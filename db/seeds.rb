# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: "Comedies")
Category.create(name: "Action")


Video.create(title: "Family Guy", description: "It's a funny video", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "../public/tmp/family_guy.jpg", category_id: "1")
Video.create(title: "Monk", description: "It's not a real monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "../public/tmp/monk_large.jpg", category_id: "1")

Review.create(body: "Family Guy is a great movie", rating: "5", user_id: "1", video_id: "1", created_at: 1.day.ago)
Review.create(body: "Family Guy is a great movie", rating: "4", user_id: "1", video_id: "1", created_at: 1.day.ago)
Review.create(body: "Family Guy is a great movie", rating: "3", user_id: "1", video_id: "1", created_at: 1.day.ago)
Review.create(body: "Family Guy is a great movie", rating: "2", user_id: "1", video_id: "1", created_at: 1.day.ago)

QueueItem.create(video_id: "1", user_id:"1", position:"1")
QueueItem.create(video_id: "2", user_id:"1", position:"2")

User.create(fullname:"teng", email:"teng@gmail.com", password:"password")