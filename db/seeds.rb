# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Monk", description: "A dective with OCD.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)
Video.create(title: "Family Guy", description: "Cartoon comedy about zany family.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category_id: 1)
Video.create(title: "Futurama", description: "From the creator of the Simpsons.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg", category_id: 1)
Video.create(title: "South Park", description: "An irreverent cartoon comedy starring 4 boys.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/south_park.jpg", category_id: 1)

Category.create(name: "TV Comedies")
