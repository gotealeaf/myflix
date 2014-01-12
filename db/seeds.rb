# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tv_commedies = Category.create(name: 'TV Commedies')
tv_dramas = Category.create(name: 'TV Dramas')
monk = Video.create(title: 'Monk', description: 'n/a', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/large.jpg', category: tv_commedies)
family_guy = Video.create(title: 'Family Guy', description: 'n/a', small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/large.jpg', category: tv_commedies)
futurama = Video.create(title: 'Futurama', description: 'n/a', small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/large.jpg', category: tv_dramas)
south_park = Video.create(title: 'South Park', description: 'n/a', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/large.jpg', category: tv_dramas)
