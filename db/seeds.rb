# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Category.create(name: "TV Comedy")
Category.create(name: "TV Drama")
Category.create(name: "Reality TV")
Video.create(title: 'Futurama', description: 'Best comedy ever', small_cover_url: '/tmp/futurama.jpg', category_id: 1) 
Video.create(title: 'Family Guy', description: 'Why did they kill Brian', small_cover_url: '/tmp/family_guy.jpg',category_id: 2)
Video.create(title: 'South Park', description: 'Equal opportunity offenders', small_cover_url: '/tmp/south_park.jpg', category_id: 3)
Video.create(title: 'Monk', description: 'Never really watched this one', small_cover_url: '/tmp/monk.jpg', category_id: 1)


