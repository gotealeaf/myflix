# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
cat = Category.create(name: "TV drama")
Video.create(title: "monk",
  description: "An American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk.",
  small_cover_url: "/tmp/monk.jpg",
  large_cover_url: "/tmp/monk_large.jpg",
  category_id: cat.id)
Video.create(title: "Family guy",
  description: "An balabala.....",
  small_cover_url: "/tmp/family_guy.jpg",
  category_id: cat.id)
Video.create(title: "Futurama",
  description: "An balabala.....",
  small_cover_url: "/tmp/futurama.jpg",
  category_id: cat.id)
