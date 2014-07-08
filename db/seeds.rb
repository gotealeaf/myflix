# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([{ name: "Comedy" }, { name: "Drama" }])
Video.create(title: "Family Guy", description: "Everyone needs a family guy.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category: categories.last)
Video.create(title: "Futurama", description: "Everyone needs a futurama.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category: categories.last)
Video.create(title: "Monk", description: "Everyone needs a monk.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: categories.first)
Video.create(title: "South Park", description: "Everyone needs a south park.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", category: categories.first)
