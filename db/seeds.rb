# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.create(name: "Family Guy", description: "The funniest cartoon ever.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg")
Video.create(name: "South Park", description: "A really great cartoon.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")
Video.create(name: "Futurama", description: "Never saw this cartoon.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
Video.create(name: "Monk", description: "Sounds pretty lame.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk.jpg")

