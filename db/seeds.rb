# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

drama = Category.create(name: 'Drama')
comedy = Category.create(name: 'Comedy')
action = Category.create(name: 'Action')
thriller = Category.create(name: 'Thriller')

Video.create(title: 'Family Guy', 
	description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company.",
	small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy.jpg',
	category: comedy)

Video.create(title: 'South Park',
	description: 'Adult animation series',
	small_cover_url: 'south_park.jpg',
	large_cover_url: 'south_park.jpg',
	category: comedy)

Video.create(title: 'Monk',
	description: 'Highly anticipated movie on monks',
	small_cover_url: 'monk.jpg',
	large_cover_url: 'monk_large.jpg',
	category: comedy)

Video.create(title: 'Rush Hour',
	description: 'The series based on the blockbuster film',
	small_cover_url: 'south_park.jpg',
	large_cover_url: 'south_park.jpg',
	category: comedy)

Video.create(title: 'Modern Family',
	description: 'A comedy on the Modern family',
	small_cover_url: 'family_guy.jpg',
	large_cover_url: 'family_guy.jpg',
	category: comedy)

Video.create(title: 'Galavant',
	description: 'A really great comedy',
	small_cover_url: 'south_park.jpg',
	large_cover_url: 'south_park.jpg',
	category: comedy)

Video.create(title: 'Devious Maids', description: 'Zoila and the gang',
	small_cover_url: 'futurama.jpg', large_cover_url: 'futurama.jpg', category: comedy)

Video.create(title: 'Mentalist', description: 'The mentalist returns',
	small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: drama)

Video.create(title: 'CSI LA', description: 'LL Cool J and the gang',
	small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy.jpg', category: drama)