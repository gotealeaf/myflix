# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.create(title: 'Monk', description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.', small_cover_url: 'tmp/monk.jpg', large_cover_url: 'tmp/monk_large', category_id: 2)
Video.create(title: 'Family Guy', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', small_cover_url: 'tmp/family_guy.jpg', large_cover_url: '', category_id: 1)
Video.create(title: 'Futurama', description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: 'tmp/futurama.jpg', large_cover_url: '', category_id: 1)
Video.create(title: 'South Park', description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.', small_cover_url: 'tmp/south_park.jpg', large_cover_url: '', category_id: 1)
categories = Category.create([{ name: 'TV Commedies' }, { name: 'TV Dramas' }, { name: 'Reality TV' }])
