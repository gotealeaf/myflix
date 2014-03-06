# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.destroy_all


Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)
Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 3.day.ago)
Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 4.day.ago)
Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 5.day.ago)
Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 6.day.ago)
Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 7.day.ago)
Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 8.day.ago)

Video.create!(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: 2, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
Video.create!(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: 2, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)

Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)
Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 3.day.ago)
Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 4.day.ago)

Review.destroy_all

2.times { Fabricate(:review, rating: 2.3)}
2.times { Fabricate(:review, rating: 4.3)}
2.times { Fabricate(:review, rating: 5.0)}
2.times { Fabricate(:review, rating: 4.2)}
2.times { Fabricate(:review, rating: 3.1)}

