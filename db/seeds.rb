# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  Video.create!(title: 'Family Guy', description: 'This is the awesome video that everybody is talking about', small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '') 
  Video.create!(title: 'Futurama', description: "Futurama, kids favourte video; it is so funny you won't believe it", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '')
  Video.create!(title: 'Monk', description: 'A video about months. Are they not awesome? You bet', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')
