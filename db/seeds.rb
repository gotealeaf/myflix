# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drama = Category.create(name: 'Drama')
scifi = Category.create(name: 'Sci-Fi')

Video.create(title: 'Annie Hall', description: 'N/A', small_cover_url: '/tmp/annie_hall.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Avengers', description: 'N/A', small_cover_url: '/tmp/avengers.jpg', large_cover_url: '/tmp/sample.jpg', category: scifi)
Video.create(title: 'Dark Night', description: 'N/A', small_cover_url: '/tmp/dark_knight.jpg', large_cover_url: '/tmp/sample.jpg', category: scifi)
Video.create(title: 'Godfather', description: 'N/A', small_cover_url: '/tmp/godfather.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Harry Potter', description: 'N/A', small_cover_url: '/tmp/harry_potter.jpg', large_cover_url: '/tmp/sample.jpg', category: scifi)
Video.create(title: 'Help', description: 'N/A', small_cover_url: '/tmp/help.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Hunt', description: 'N/A', small_cover_url: '/tmp/hunt.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Love Actually', description: 'N/A', small_cover_url: '/tmp/love_actually.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Man On Fire', description: 'N/A', small_cover_url: '/tmp/man_on_fire.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Misery', description: 'N/A', small_cover_url: '/tmp/misery.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Moon', description: 'N/A', small_cover_url: '/tmp/moon.jpg', large_cover_url: '/tmp/sample.jpg', category: scifi)
Video.create(title: 'No', description: 'N/A', small_cover_url: '/tmp/no.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Outrage', description: 'N/A', small_cover_url: '/tmp/outrage.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Seven', description: 'N/A', small_cover_url: '/tmp/seven.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
Video.create(title: 'Star Trek', description: 'N/A', small_cover_url: '/tmp/star_trek.jpg', large_cover_url: '/tmp/sample.jpg', category: scifi)
Video.create(title: 'Trainspotting', description: 'N/A', small_cover_url: '/tmp/trainspotting.jpg', large_cover_url: '/tmp/sample.jpg', category: drama)
