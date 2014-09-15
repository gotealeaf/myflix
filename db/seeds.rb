# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

v1 = Video.create(title: "Monk", description: "The best new series on Myflix!", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg")
v2 = Video.create(title: "Monk", description: "The best new series on Myflix!", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg")
v3 = Video.create(title: "Monk", description: "The best new series on Myflix!", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg")
v4 = Video.create(title: "Monk", description: "The best new series on Myflix!", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg")
v5 = Video.create(title: "Monk", description: "The best new series on Myflix!", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg")


hor = Category.create(name: "Horror")
Category.create(name: "Drama")
Category.create(name: "Comedy")

lord = User.create(full_name: "lord", password: "password", email: "ass@yahoo.com")

Review.create(user: lord, video: v1, rating: 3, content: "Really good movie")
Review.create(user: lord, video: v1, rating: 3, content: "Really good jk movie")
