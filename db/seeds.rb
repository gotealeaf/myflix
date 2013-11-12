# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedies = Category.create(name: "Comedies")
dramas = Category.create(name: "Dramas")

Video.create(title: "Futurama", description: "Never watched it 6", small_cover_url: "/tmp/futurama.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Monk", description: "Almost famous 7", small_cover_url: "/tmp/monk.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Futurama", description: "Almost famous 8", small_cover_url: "/tmp/family_guy.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park part 5", description: "Hippie Kids 9", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
monk = Video.create(title: "Futur", description: "Never watched it 1", small_cover_url: "/tmp/futurama.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Monkeys", description: "Almost famous 2", small_cover_url: "/tmp/monk.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Urama", description: "Almost famous 5", small_cover_url: "/tmp/family_guy.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "Hippie Kids 3", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Southie Park", description: "Hippie Kids 10", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Monkey", description: "Almost famous 4", small_cover_url: "/tmp/monk.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "turama", description: "Almost famous 007", small_cover_url: "/tmp/family_guy.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Parks Man", description: "Hippie Kids 112", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park3", description: "Hippie Kidies 13", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")

david = User.create(full_name: "David Advent", password: "password", email: "david@yahoo.com")
Review.create(user: david, video: monk, rating: 3, content: "this is a really good movie!")
Review.create(user: david, video: monk, rating: 2, content: "this is a really soso movie!")