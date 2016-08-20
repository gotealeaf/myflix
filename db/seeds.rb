# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.create(title: 'Family Guy', 
	description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company.",
	small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/family_guy.jpg')

Video.create(title: 'South Africa',
	description: 'Adult animation series',
	small_cover_url: '/tmp/south_park.jpg',
	large_cover_url: '/tmp/south_park.jpg')

Video.create(title: 'Monk',
	description: 'Highly anticipated movie on monks',
	small_cover_url: '/tmp/monk.jpg',
	large_cover_url: '/tmp/large_large.jpg')

Category.create(name: 'Drama')
Category.create(name: 'Comedy')
Category.create(name: 'Action')
Category.create(name: 'Thriller')