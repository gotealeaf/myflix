# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'TV Comedy')
Category.create(name: 'TV Drama')

monk = Video.create(
  title:           'Monk',
  description:     'A San Francisco detective with some peculier ' + 
                     'habbits solves some interesting crimes.',
  small_cover_url: '/tmp/monk.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:         Category.find_by(name: 'TV Drama')
)

futurama = Video.create(
  title:           'Futurama',
  description:     'A New York slacker wakes up in the future.',
  small_cover_url: '/tmp/futurama.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:        Category.find_by(name: 'TV Comedy')
)

Video.create(
  title:           'South Park',
  description:     'A group of middile schoolers learn about life.',
  small_cover_url: '/tmp/south_park.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:        Category.find_by(name: 'TV Comedy')
)

Video.create(
  title:           'Family Guy',
  description:     'A family deals with an overweight alcoholic father.',
  small_cover_url: '/tmp/family_guy.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:        Category.find_by(name: 'TV Comedy')
)

Video.create(
  title:           'Monk',
  description:     'A San Francisco detective with some peculier ' + 
                     'habbits solves some interesting crimes.',
  small_cover_url: '/tmp/monk.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:         Category.find_by(name: 'TV Drama')
)

Video.create(
  title:           'Futurama',
  description:     'A New York slacker wakes up in the future.',
  small_cover_url: '/tmp/futurama.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:        Category.find_by(name: 'TV Comedy')
)

Video.create(
  title:           'South Park',
  description:     'A group of middile schoolers learn about life.',
  small_cover_url: '/tmp/south_park.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:        Category.find_by(name: 'TV Comedy')
)

Video.create(
  title:           'Family Guy',
  description:     'A family deals with an overweight alcoholic father.',
  small_cover_url: '/tmp/family_guy.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:        Category.find_by(name: 'TV Comedy')
)

Video.create(
  title:           'South Park',
  description:     'A group of middile schoolers learn about life.',
  small_cover_url: '/tmp/south_park.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category:        Category.find_by(name: 'TV Comedy')
)

bilbo = User.create(
  email:                  'bilbo@shire.com',
  full_name:              'Bilbo Baggins',
  password:               'smaug',
  password_confirmation:  'smaug'
)

frodo = User.create(
  email:                  'frodo@shire.com',
  full_name:              'Frodo Baggins',
  password:               'nazgul',
  password_confirmation:  'nazgul'
)

Review.create(
  user:         bilbo,
  video:        monk,
  rating:       4,
  content:      Faker::Lorem.paragraph(2)
)

Review.create(
  user:         frodo,
  video:        monk,
  rating:       3,
  content:      Faker::Lorem.paragraph(3)
)

QueueItem.create(
  user: bilbo,
  video: monk,
  position: 1
)

QueueI tem.create(
  user: bilbo,
  video: futurama,
  position: 2
)