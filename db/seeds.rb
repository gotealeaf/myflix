# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

video1 = Video.create(title: 'Family Guy', description: "Family guy description here", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg")
video2 = Video.create(title: 'Futurama', description: "Futurama description here", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
video3 = Video.create(title: 'South Park', description: "South Park description here", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")
video4 = Video.create(title: 'Monk', description: "Monk description here", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
video5 = Video.create(title: 'Monk', description: "Monk description here", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
video6 = Video.create(title: 'Family Guy', description: "Family guy description here", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg")
video7 = Video.create(title: 'Futurama', description: "Futurama description here", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
video8 = Video.create(title: 'South Park', description: "South Park description here", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")
video9 = Video.create(title: 'Monk', description: "Monk description here", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
video10 = Video.create(title: 'Monk', description: "Monk description here", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
video11 = Video.create(title: 'Family Guy', description: "Family guy description here", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg")
video12 = Video.create(title: 'Futurama', description: "Futurama description here", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
video13 = Video.create(title: 'South Park', description: "South Park description here", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")
video14 = Video.create(title: 'Monk', description: "Monk description here", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
video15 = Video.create(title: 'Monk', description: "Monk description here", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")


comedy = Category.create(name: "Comedy")
drama = Category.create(name: "Drama")

video1.categories << comedy
video2.categories << comedy
video3.categories << comedy
video4.categories << drama
video5.categories << drama
video6.categories << comedy
video7.categories << comedy
video8.categories << comedy
video9.categories << drama
video10.categories << drama
video11.categories << comedy
video12.categories << comedy
video13.categories << comedy
video14.categories << drama
video15.categories << drama