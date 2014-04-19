# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# "Put in seed data about videos... Southpark, etc are in public/tmp/"

Video.create(title: "Road Runner", description: "Chased constantly!", small_cover_url: "/tmp/road_runner.jpg", large_cover_url: "/tmp/road_runner_large.jpg", category_id: 1)
Video.create(title: "Bugs Bunny", description: "A bunny with bugs.", small_cover_url: "/tmp/bugs_bunny.jpg", large_cover_url: "/tmp/bugs_bunny_large.jpg", category_id: 3)
Video.create(title: "Foghorn Leghorn", description: "A large, southern rooster.", small_cover_url: "/tmp/foghorn.jpg", large_cover_url: "/tmp/foghorn_large.jpg", category_id: 2)
Video.create(title: "Tom & Jerry", description: "Quite a cat & mouse scene!", small_cover_url: "/tmp/tom_jerry.jpg", large_cover_url: "/tmp/tom_jerry_large.jpg", category_id: 1)
Category.create(name: "Chase movies")
Category.create(name: "Farm shows")
Category.create(name: "Animal cartoons")

