# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    Video.create(title: 'Monk', description: "A very clever TV show", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg")
    Video.create(title: 'Future Family', description: "Family guy in the future", small_cover_url: "family_guy.jpg", large_cover_url: "south_park.jpg")

