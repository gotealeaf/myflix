# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.find_or_create_by(title: "Futurama") do |video|
  video.description = "A show about a pizza guy who was cryogenically frozen"
  video.small_cover_url = "/tmp/futurama.jpg"
end

Video.find_or_create_by(title: "South Park") do |video|
  video.description = "Animated friends raise havok in Colorado"
  video.small_cover_url = "/tmp/south_park.jpg"
end

Video.find_or_create_by(title: "Family Guy") do |video|
  video.description = "Peter and his family go on all sorts of adventures"
  video.small_cover_url = "/tmp/family_guy.jpg"
end

Video.find_or_create_by(title: "Monk") do |video|
  video.description = "Something something detective something."
  video.small_cover_url = "/tmp/monk.jpg"
  video.large_cover_url = "monk_large.jpg"
end