# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

   videos = Video.create(
       name: 'Family Guy', 
         description: 'Family guy series is awesome',
         cover_image_url: '/tmp/family_guy.jpg')
