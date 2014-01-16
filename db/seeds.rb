# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


action = Category.create(name: "Actions")
love = Category.create(name: "Love")
kungfu = Video.create(title: "Toy Story", description: "Toy Story", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)

Video.create(title: "south_park", description: "south_park", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)

Video.create(title: "family_guy", description: "family_guy", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)
Video.create(title: "Toy Story", description: "Toy Story", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)

Video.create(title: "south_park", description: "south_park", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)

Video.create(title: "family_guy", description: "family_guy", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)
Video.create(title: "Toy Story", description: "Toy Story", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)

Video.create(title: "south_park", description: "south_park", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 1)

Video.create(title: "family_guy", description: "family_guy", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 2)

neil = User.create(full_name: "Neil Wang", password: "password", email: "neil@gmail.com")

Review.create(user: neil, video: kungfu, rate: 3, review: "alsdkfj") 
Review.create(user: neil, video: kungfu, rate: 4, review: "good video") 

