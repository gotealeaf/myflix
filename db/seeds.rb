# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


comedy = Category.create(name: "Comedy")
drama = Category.create(name: "Drama")



Video.create(
            title: "Family Guy", 
            description: "Follow the adventures of an endearingly ignorant dad, PETER GRIFFIN, and his hilariously odd family.",
            small_cover_url: "/tmp/family_guy.jpg",
            large_cover_url: "/tmp/family_guy.jpg",
            category: comedy
            )
Video.create(
            title: "Monk", 
            description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhou.",
            small_cover_url: "/tmp/monk.jpg",
            large_cover_url: "/tmp/monk_large.jpg",
            category: drama
            )
Video.create(
            title: "South Park", 
            description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network.",
            small_cover_url: "/tmp/south_park.jpg",
            large_cover_url: "/tmp/south_park.jpg",
            category: comedy
            )
