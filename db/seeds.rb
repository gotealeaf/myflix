# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#5.times do |f|
#  Video.create(title: 'SouthPark', small_cover_url: '/tmp/monk.jpg', description: "Wonderful #{f} data", large_cover_url: '/tmp/monk_large.jpg')
#end

Category.create(name: 'Commedies')
Category.create(name: 'Dramas')
Category.create(name: 'Reality')