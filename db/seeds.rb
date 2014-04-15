# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# "Put in seed data about videos... Southpark, etc are in public/tmp/"

Video.create(title: "Family Guy", description: "A guy with a family.", small_cover_url: "/tmp/family_guy.jpg")
Video.create(title: "Futurama", description: "A drama with a future.", small_cover_url: "/tmp/futurama.jpg")
Video.create(title: "Monk", description: "A man named Monk.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "South Park", description: "A park in the South.", small_cover_url: "/tmp/south_park.jpg")
