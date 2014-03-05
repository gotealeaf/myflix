# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(
  title:           'Monk',
  description:     'A San Francisco detective with some peculier ' + 
                     'habbits solves some interesting crimes.',
  small_cover_url: 'public/temp/monk.jpg',
  large_cover_url: 'public/temp/monk_large.jpg'
)

Video.create(
  title:           'Futurama',
  description:     'A New York slacker wakes up in the future.',
  small_cover_url: 'public/temp/futurama.jpg',
  large_cover_url: 'public/temp/monk_large.jpg'
)

Video.create(
  title:           'South Park',
  description:     'A group of middile schoolers learn about life.',
  small_cover_url: 'public/south_park.jpg',
  large_cover_url: 'public/temp/monk_large.jpg'
)

Video.create(
  title:           'Family Guy',
  description:     'A family deals with an overweight alcoholic father.',
  small_cover_url: 'public/temp/family_guy.jpg',
  large_cover_url: 'public/temp/monk_large.jpg'
)
