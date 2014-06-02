# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Videos

Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series.", small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/futurama.jpg")
Video.create(title: "Family Guy", description: "The show follows the adventures of an endearingly ignorant dad, PETER GRIFFIN (Seth MacFarlane), and his hilariously odd family of middle-class New Englanders.", small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/family_guy.jpg")
monk1 = Video.create(title: "Monk", description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character.", small_cover: "/tmp/monk.jpg", large_cover: "/tmp/monk_large.jpg")
Video.create(title: "South Parl", description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network", small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/south_park.jpg")
Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series.", small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/futurama.jpg")
Video.create(title: "Family Guy", description: "The show follows the adventures of an endearingly ignorant dad, PETER GRIFFIN (Seth MacFarlane), and his hilariously odd family of middle-class New Englanders.", small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/family_guy.jpg")
Video.create(title: "Monk", description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character.", small_cover: "/tmp/monk.jpg", large_cover: "/tmp/monk_large.jpg")
Video.create(title: "South Parl", description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network", small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/south_park.jpg")
Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series.", small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/futurama.jpg")
Video.create(title: "Family Guy", description: "The show follows the adventures of an endearingly ignorant dad, PETER GRIFFIN (Seth MacFarlane), and his hilariously odd family of middle-class New Englanders.", small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/family_guy.jpg")
Video.create(title: "Monk", description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character.", small_cover: "/tmp/monk.jpg", large_cover: "/tmp/monk_large.jpg")
Video.create(title: "South Parl", description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network", small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/south_park.jpg")
Video.create(title: "South Parl", description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network", small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/south_park.jpg")

Category.create(name: "Action")
Category.create(name: "Comedy")
Category.create(name: "Drama")
Category.create(name: "Romance")

VideoCategory.create(category_id: 1, video_id: 3)
VideoCategory.create(category_id: 2, video_id: 1)
VideoCategory.create(category_id: 3, video_id: 3)
VideoCategory.create(category_id: 4, video_id: 2)
VideoCategory.create(category_id: 2, video_id: 4)
VideoCategory.create(category_id: 1, video_id: 2)
VideoCategory.create(category_id: 4, video_id: 1)
VideoCategory.create(category_id: 3, video_id: 2)
VideoCategory.create(category_id: 1, video_id: 9)
VideoCategory.create(category_id: 1, video_id: 10)
VideoCategory.create(category_id: 1, video_id: 11)
VideoCategory.create(category_id: 1, video_id: 12)
VideoCategory.create(category_id: 1, video_id: 13)

jane = User.create(full_name: "Jane One", email: "jane@example.com", password: "password", admin: true)
seconduser = User.create(full_name: "Second User", email: "seconduser@example.com", password: "password", admin: false)

Review.create(user: jane, video: monk1, content: "Not bad at all", rating: 3)
Review.create(user: jane, video: monk1, content: "Terrible, waste of time", rating: 1)
