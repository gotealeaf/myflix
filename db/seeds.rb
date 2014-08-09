# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pulp_fiction = Video.create(title: "Pulp Fiction", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1, description: "A great movie.")
Video.create(title: "Reservoir Dogs", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1, description: "A good movie.")
Video.create(title: "Django Unchained", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1, description: "An excellent movie.")

Category.create(name: "Action")
Category.create(name: "Comedy")

boris = User.create(full_name: "Boris Smirnoff", password: "password", email: "boris@mail.com")

Review.create(user: boris, video: pulp_fiction, rating: 5, content: "This is a great movie")
Review.create(user: boris, video: pulp_fiction, rating: 2, content: "This is a lousy movie")
