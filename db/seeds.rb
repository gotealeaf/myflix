# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Video.create(title: "My Cousin Vinny", description: "This is  very funny movie. I recommend it highly.", small_cover_url: "/public/tmp/monk.jpg", large_cover_url: "public/tmp/monk_large.jpg")
Video.create(title: "Sarah", description: "Witty and complicated, this movie will bring you to tears.", small_cover_url: "/public/tmp/monk.jpg", large_cover_url: "public/tmp/monk_large.jpg")
Video.create(title: "A day in the life of Clint", description: "This is a 0 star flick.  Boring", small_cover_url: "/public/tmp/monk.jpg", large_cover_url: "public/tmp/monk_large.jpg")
