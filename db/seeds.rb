# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedies = Category.create(name: "Comedies")
dramas = Category.create(name: "Dramas")

Video.create(title: "Futurama", description: "Never watched it", small_cover_url: "/tmp/futurama.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Monk", description: "Almost famous", small_cover_url: "/tmp/monk.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Futurama", description: "Almost famous", small_cover_url: "/tmp/family_guy.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "Hippie Kids", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Futurama", description: "Never watched it", small_cover_url: "/tmp/futurama.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Monk", description: "Almost famous", small_cover_url: "/tmp/monk.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Futurama", description: "Almost famous", small_cover_url: "/tmp/family_guy.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "Hippie Kids", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "Hippie Kids", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Monk", description: "Almost famous", small_cover_url: "/tmp/monk.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Futurama", description: "Almost famous", small_cover_url: "/tmp/family_guy.jpg", category: dramas, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "Hippie Kids", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "Hippie Kids", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: "/tmp/monk_large.jpg")