# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.destroy_all
Video.destroy_all
Review.destroy_all

comedies = Category.create(name: "Comedies")
Category.create(name: "Mysteries")
Category.create(name: "Tragedies")


video = Video.create(title: "Monk", description: "OCD TV.  This is a show about a clean-cut man who likes to be clean.  Too clean, some would say.  Buy now!", small_url: "/tmp/monk.jpg" , large_url: "/tmp/monk_large.jpg", category: comedies)

Video.create(title: "Family Guy", description: "A comedy if you live in an upper-middle class suburb of New York.  Otherwise, a mystery.  Buy now!" , small_url: "/tmp/family_guy.jpg", category: comedies)

Video.create(title: "Futurama", description: "How people from the early 2000s viewed the future we now live in." , small_url: "/tmp/futurama.jpg", category: comedies)

3.times {Video.create(title: "South Park", description: "A true, heartwarming story about society's ignorance." , small_url: "/tmp/south_park.jpg", category: comedies)}


review1 = Review.create(rating: 4, content: "Great show.  Great review.  Great reviewer.")
review2 = Review.create(rating: 5, content: "I absolutely love anything on TV.")
video.reviews << review1 << review2
user = User.first
user.reviews << review1 << review2

