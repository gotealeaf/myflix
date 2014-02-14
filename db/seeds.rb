# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

lore_ipsum_description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean justo neque, scelerisque sed convallis laoreet, porta vel velit. Duis vel ornare augue. Nunc iaculis augue nunc, sed elementum libero porta vel. Suspendisse potenti. In viverra, augue ultrices malesuada mattis, massa mi condimentum erat, at ultrices velit quam sed lorem. Duis aliquet ante vel vulputate consequat. Sed faucibus dui sit amet arcu posuere pretium. Donec nisl ante, porttitor at nisl vitae, cursus lacinia dui.'

Video.create(name: 'El dia de la bestia', description: lore_ipsum_description, short_image_url: '/tmp/the_day_of_the_beast.jpg', large_image_url: '')
Video.create(name: 'El dia de la bestia', description: lore_ipsum_description, short_image_url: '/tmp/family_guy.jpg', large_image_url: '')
Video.create(name: 'El dia de la bestia', description: lore_ipsum_description, short_image_url: '/tmp/monk.jpg', large_image_url: '/tmp/monk_large.jpg')
Video.create(name: 'El dia de la bestia', description: lore_ipsum_description, short_image_url: '/tmp/south_park.jpg', large_image_url: '')
