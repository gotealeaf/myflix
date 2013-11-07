# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Futurama = Video.create(title: 'Futurama', description: 'Never watched it', small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/monk_large.jpg')
Monk = Video.create(title: 'Futurama', description: 'Almost famous', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')