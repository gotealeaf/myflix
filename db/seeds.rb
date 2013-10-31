# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: 'Family Guy', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/family_guy_large.jpg')
Video.create(title: 'Futurama', description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
Video.create(title: 'South Park', description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/south_park_large.jpg')
Video.create(title: 'Breaking Bad', description: "To provide for his family's future after he is diagnosed with lung cancer, a chemistry genius turned high school teacher teams up with an ex-student to cook and sell the world's purest crystal meth.", small_cover_url: '/tmp/breaking_bad.jpg', large_cover_url: '/tmp/breaking_bad_large.jpg')
Video.create(title: 'The Walking Dead', description: 'Police officer Rick Grimes leads a group of survivors in a world overrun by zombies.', small_cover_url: '/tmp/walking_dead.jpg', large_cover_url: '/tmp/walking_dead_large.jpg')

Category.create(name: 'TV Comedy')
Category.create(name: 'TV Drama')

