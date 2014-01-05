# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

thriller = Category.create(name: 'Thriller')
scifi = Category.create(name: 'ScienceFiction')
 
videos = Video.create([{title: 'Inception', 
	                      description: 'Science Fiction thriller by Christopher Nolan',
	                      small_cover_url: '/tmp/inception.jpg',
	                      large_cover_url:'/tmp/inception.jpg',
	                      category: scifi},

	                      {title: 'Drive', 
	                      description: 'Masterpiece by Nicolas Winding Refn',
	                      small_cover_url: '/tmp/drive.jpg',
	                      large_cover_url:'/tmp/drive.jpg',
	                      category: thriller},

	                      {title: 'Lost Highway', 
	                      description: 'Crazy, hypnotic and stylish movie by David Lynch',
	                      small_cover_url: '/tmp/lost_highway.jpg',
	                      large_cover_url:'/tmp/lost_highway.jpg',
	                      category: thriller}])