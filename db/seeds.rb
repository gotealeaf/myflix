# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 Video.delete_all
 Category.delete_all
 
c1 = Category.create(title: "dramas")
c2 = Category.create(title: "Detective Series")
c3 = Category.create(title: "Comedy")
  
Video.create(name: "Futurama", description: "space travel!", small_cover_url: "/tmp/futurama.jpg", category_id: c1, large_cover_url: '/tmp/monk_large.jpg')

Video.create(name: "Monk", description: "Paranoid SF detective", small_cover_url: "/tmp/monk.jpg", category_id: c2, large_cover_url: '/tmp/monk_large.jpg')

Video.create(name: "Futurama", description: "space travel!", small_cover_url: "/tmp/mok.jpg", category_id: c1, large_cover_url: '/tmp/monk_large.jpg')

Video.create(name: "Family Guy", description: "Peter Griffin and talking dog", small_cover_url: "/tmp/family.jpg", category_id: c3, large_cover_url: '/tmp/monk_large.jpg')

Video.create(name: "Futurama", description: "space travel!", small_cover_url: "/tmp/futuramaa.jpg", category_id: c1, large_cover_url: '/tmp/monk_large.jpg')

Video.create(name: "Futurama", description: "space travel!", small_cover_url: "/tmp/mok.jpg", category_id: c1, large_cover_url: '/tmp/monk_large.jpg')
