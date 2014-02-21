# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.destroy_all

4.times do
	Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg")
	Video.create!(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: 1, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg")
	Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 1, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg")

	Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 2, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg")
	Video.create!(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: 2, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg")
	Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 2, category_id: 1, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg")

	Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 3, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg")
	Video.create!(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: 3, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg")
	Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, category_id: 1, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg")
end