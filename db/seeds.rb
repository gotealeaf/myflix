# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedies = Category.create(name: "TV Comedies")
dramas = Category.create(name: "TV Dramas")
reality = Category.create(name: "Reality TV")

Video.create(title: "Family Guy", description: "This is family guy movie description", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category: dramas)
Video.create(title: "Futurama", description: "This is futurama movie description", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedies)
monk = Video.create(title: "Monk", description: "This is monk movie description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: dramas)
Video.create(title: "South Park", description: "This is south park movie description", small_cover_url: "/tmp/south_park.jpg", large_cover_url:"/tmp/monk_large.jpg", category: reality)
Video.create(title: "Family Guy", description: "This is family guy movie description", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedies)
Video.create(title: "Futurama", description: "This is futurama movie description", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category: dramas)
Video.create(title: "Monk", description: "This is monk movie description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedies)
Video.create(title: "South Park", description: "This is south park movie description", small_cover_url: "/tmp/south_park.jpg", large_cover_url:"/tmp/monk_large.jpg", category: reality)
Video.create(title: "Family Guy", description: "This is family guy movie description", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedies)
Video.create(title: "Futurama", description: "This is futurama movie description", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category: reality)
Video.create(title: "Monk", description: "This is monk movie description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedies)
Video.create(title: "South Park", description: "This is south park movie description", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", category: reality)
Video.create(title: "Family Guy", description: "This is family guy movie description", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedies)
Video.create(title: "Futurama", description: "This is futurama movie description", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category: dramas)
Video.create(title: "Monk", description: "This is monk movie description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: dramas)
Video.create(title: "South Park", description: "This is south park movie description", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", category: reality)

denny = User.create(full_name: "Denny Santoso", password: "admin", password_confirmation: "admin", email: "dennysantoso@example.com")

Review.create(user: denny, video: monk, rating: 5, content: "This is really good movie")
Review.create(user: denny, video: monk, rating: 2, content: "This is horrible movie")
