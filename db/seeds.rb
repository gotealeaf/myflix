# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
video1 = Video.create(title: 'title1', description: 'test', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video2 = Video.create(title: 'title2', description: 'test2', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
sport = Category.create(name: 'sport')

sport.videos << video1
sport.videos << video2
