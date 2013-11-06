# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Family Guy", description: "This is family guy movie description", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "")
Video.create(title: "Futurama", description: "This is futurama movie description", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "")
Video.create(title: "Monk", description: "This is monk movie description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "This is south park movie description", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "")