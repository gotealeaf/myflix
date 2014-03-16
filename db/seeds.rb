# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
video1 = Video.create(title: 'title1', description: 'test', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video2 = Video.create(title: 'title2', description: 'test2', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video3 = Video.create(title: 'title3', description: 'test', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video4 = Video.create(title: 'title4', description: 'test', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video5 = Video.create(title: 'title5', description: 'test', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video6 = Video.create(title: 'title6', description: 'test2', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video7 = Video.create(title: 'title7', description: 'test2', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
video8 = Video.create(title: 'title8', description: 'test2', small_cover_url: "/tmp/futurama.jpg", big_cover_url: "/tmp/monk_large.jpg")
sport = Category.create(name: 'sport', videos: [video1, video2, video3, video4, video5, video6] )
news = Category.create(name: 'news', videos: [video7, video8])
