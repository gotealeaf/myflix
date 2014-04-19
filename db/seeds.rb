# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
video1 = Video.create(title: 'Monk', description: 'A comedy obsesive compulsives', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg' )
video2 = Video.create(title: 'South Park', description: 'Cheesy Pooffs', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/south_park.jpg' )
cat1 = Category.create(name: 'Comedy')
# cat2 = Category.create(name: 'Crime')
# cat3 = Category.create(name: 'Drama')
VideoCategory.create(category: cat1 , video: video1 )
VideoCategory.create(category: cat1 , video: video2 )
# VideoCategory.create(category: cat2 , video: video2 )
# VideoCategory.create(category: cat3 , video: video2 )
