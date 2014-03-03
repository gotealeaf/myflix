# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Video.create(title: "Futurama", description: "Philip J Fry blah blah", 
#              small_cover_url: "/tmp/futurama.jpg",
#              large_cover_url: "/tmp/futurama_large.jpg")
# Video.create(title: "Family Guy", description: "Seth McFarlane blah blah Canada sucks", 
#              small_cover_url: "/tmp/family_guy.jpg", 
#              large_cover_url: "/tmp/family_guy_large.jpg")
# Video.create(title: "Monk", description: "OCD detective shenanigans", 
#              small_cover_url: "/tmp/monk.jpg", 
#              large_cover_url: "/tmp/monk_large.jpg")
# Video.create(title: "South Park", description: "Fourth grade political commentary",
#              small_cover_url: "/tmp/south_park.jpg",
#              large_cover_url: "/tmp/south_park_large.jpg")

# Category.create(name: "TV Comedies")
# Category.create(name: "TV Dramas")
# Category.create(name: "Action Movies")

# Video.create(title: "Breaking Bad", description: "Walter White, meth, Felina, etc.", 
#              small_cover_url: "/tmp/breaking_bad.jpg",
#              large_cover_url: "/tmp/breaking_bad_large.jpg",
#              category_id: 2)
# Video.create(title: "Heroes", description: "Only season 1 was good blah blah why is this coming back", 
#              small_cover_url: "/tmp/heroes.jpg", 
#              large_cover_url: "/tmp/heroes_large.jpg",
#              category_id: 2)
# Video.create(title: "Sherlock", description: "Benedict Cumberbatch blah blah kinda stopped watching", 
#              small_cover_url: "/tmp/sherlock.jpg", 
#              large_cover_url: "/tmp/sherlock_large.jpg",
#              category_id: 2)
# Video.create(title: "Walking Dead", description: "Zombies, zombies, more zombies, ratings blockbuster",
#              small_cover_url: "/tmp/walking_dead.jpg",
#              large_cover_url: "/tmp/walking_dead_large.jpg",
#              category_id: 2)
# Video.create(title: "24", description: "Jack Bauer blah blah sorta excited this is coming back",
#              small_cover_url: "/tmp/24.jpg",
#              large_cover_url: "/tmp/24_large.jpg",
#              category_id: 2)

# futurama = Video.find_by(title: "Futurama")
# futurama.category_id = 1
# futurama.save

# family_guy = Video.find_by(title: "Family Guy")
# family_guy.category_id = 1
# family_guy.save

# south_park = Video.find_by(title: "South Park")
# south_park.category_id = 1
# south_park.save

# monk = Video.find_by(title: "Monk")
# monk.category_id = 1
# monk.save

# Video.create(title: "Iron Man 3", description: "Tony Stark blah blah overhyped fireworks",
#              small_cover_url: "/tmp/iron_man_3.jpg",
#              large_cover_url: "/tmp/iron_man_3_large.jpg",
#              category_id: 3)

Video.create(title: "King of the Hill", description: "Mike Judge blah blah",
             small_cover_url: "/tmp/king_of_the_hill.jpg",
             large_cover_url: "/tmp/king_of_the_hill_large.jpg",
             category_id: 1)

Video.create(title: "Archer", description: "H. Jon Benjamin blah blah",
             small_cover_url: "/tmp/archer.jpg",
             large_cover_url: "/tmp/archer_large.jpg",
             category_id: 1)

Video.create(title: "Bob's Burgers", description: "Yum burgers blah blah",
             small_cover_url: "/tmp/bobs_burgers.jpg",
             large_cover_url: "/tmp/bobs_burgers_large.jpg",
             category_id: 1)

