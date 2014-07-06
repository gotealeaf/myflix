# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.destroy_all
Video.destroy_all

Category.create(name: "Comedies")
Category.create(name: "Mysteries")
Category.create(name: "Tragedies")


Video.create(title: "Monk", description: "OCD TV.  This is a show about a clean-cut man who likes to be clean.  Too clean, some would say.  Buy now!", small_url: "/tmp/monk.jpg" , large_url: "/tmp/monk_large.jpg")

Video.create(title: "Family Guy", description: "A comedy if you live in an upper-middle class suburb of New York.  Otherwise, a mystery.  Buy now!" , small_url: "/tmp/family_guy.jpg")

Video.create(title: "Futurama", description: "How people from the early 2000s viewed the future we now live in." , small_url: "/tmp/futurama.jpg")

Video.create(title: "South Park", description: "A true, heartwarming story about society's ignorance." , small_url: "/tmp/south_park.jpg")

