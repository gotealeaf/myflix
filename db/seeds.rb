# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedy = Category.create(name: "TV Comedies")
drama = Category.create(name: "Dramas")

Video.create(title: "Monk", description: "A dective with OCD.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: drama)
Video.create(title: "Family Guy", description: "Cartoon comedy about zany family.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category: comedy)
Video.create(title: "Futurama", description: "From the creator of the Simpsons.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg", category: comedy)
Video.create(title: "South Park", description: "An irreverent cartoon comedy starring 4 boys.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg", category: comedy)
Video.create(title: "Monk", description: "A dective with OCD.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: drama)
Video.create(title: "Family Guy", description: "Cartoon comedy about zany family.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category: comedy)
Video.create(title: "Futurama", description: "From the creator of the Simpsons.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg", category: comedy)
Video.create(title: "South Park", description: "An irreverent cartoon comedy starring 4 boys.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg", category: comedy)
Video.create(title: "Monk", description: "A dective with OCD.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedy)

jamie = User.create(fullname: "Jamie Bobber", email: "jb@jb.net", password: "password")
johnny = User.create(fullname: "Johnny Nooler", email: "jn@jn.net", password: "password")
maria = User.create(fullname: "Maria Mendez", email: "mm@mm.net", password: "password", followed_users:[jamie, johnny])