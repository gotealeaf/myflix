# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


category1 = Category.create(name: "Romantic Comedy");
category2 = Category.create(name: "Action Thriller");

category2.videos << Video.new(title: "Deep Impact", description: "Wow, a gret movie", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
category2.videos << Video.new(title: "Air Force 1", description: "Stunning", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg")
category1.videos << Video.new(title: "Notebook", description: "I cried", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
category1.videos << Video.new(title: "Yes Man", description: "Must see", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg")
