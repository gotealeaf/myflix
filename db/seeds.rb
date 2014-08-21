# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedy = Category.create(name: "TV Comedies")
drama = Category.create(name: "Dramas")

Video.create(title: "Monk", 
  description: "A dective with OCD.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/monk.jpg")), 
  large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")), 
  category_id: 2)

Video.create(title: "Family Guy", 
  description: "Cartoon comedy about zany family.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/family_guy.jpg")), 
  large_cover: File.open(File.join(Rails.root, "public/tmp/family_guy.jpg")), 
  category_id: 1)

Video.create(title: "Futurama", 
  description: "From the creator of the Simpsons.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/futurama.jpg")), 
  large_cover: File.open(File.join(Rails.root, "public/tmp/futurama.jpg")), 
  category_id: 1)

Video.create(title: "South Park", 
  description: "An irreverent cartoon comedy starring 4 boys.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/south_park.jpg")), 
  large_cover: File.open(File.join(Rails.root, "public/tmp/south_park.jpg")), 
  category_id: 1)
Video.create(title: "Monk", 
  description: "A dective with OCD.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/monk.jpg")), 
  large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")), 
  category_id: 2)

Video.create(title: "Family Guy", 
  description: "Cartoon comedy about zany family.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/family_guy.jpg")), 
  large_cover: File.open(File.join(Rails.root, "public/tmp/family_guy.jpg")), 
  category_id: 1)

Video.create(title: "Futurama", 
  description: "From the creator of the Simpsons.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/futurama.jpg")), 
  large_cover: File.open(File.join(Rails.root, "public/tmp/futurama.jpg")), 
  category_id: 1)

Video.create(title: "South Park", 
  description: "An irreverent cartoon comedy starring 4 boys.", 
  small_cover: File.open(File.join(Rails.root, "/public/tmp/south_park.jpg")), 
  large_cover: File.open(File.join(Rails.root, "public/tmp/south_park.jpg")), 
  category_id: 1)


jim = User.create(fullname: "Jim Bobby", email: "cool@cool.com", password: "password", admin: true)
jamie = User.create(fullname: "Jamie Bobber", email: "jb@jb.net", password: "password")
johnny = User.create(fullname: "Johnny Nooler", email: "jn@jn.net", password: "password")
maria = User.create(fullname: "Maria Mendez", email: "mm@mm.net", password: "password", followed_users:[jamie, johnny])