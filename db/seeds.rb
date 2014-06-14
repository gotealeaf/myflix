# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

action = Category.create(name: "Action")
comedy =  Category.create(name: "Comedy")
romance = Category.create(name: "Romance")
drama = Category.create(name: "Drama")

# Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg", category: action)
# Video.create(title: "Family Guy", description: "The show follows the adventures of an endearingly ignorant dad, PETER GRIFFIN (Seth MacFarlane), and his hilariously odd family of middle-class New Englanders.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category: romance)
# monk = Video.create(title: "Monk", description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: drama)
# Video.create(title: "South Park", description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg", category: action)
# Video.create(title: "Friends", description: "Friends is an American television sitcom created by David Crane and Marta Kauffman, which originally aired on NBC from September 22, 1994 to May 6, 2004.", small_cover_url: "/tmp/friends.jpg", large_cover_url: "/tmp/friends_large.jpg", category: comedy)
# Video.create(title: "How I met you mother", description: "How I Met Your Mother (often abbreviated to HIMYM) is an American sitcom that originally ran on CBS from September 19, 2005 to March 31, 2014.", small_cover_url: "/tmp/how_met_mother.jpg", large_cover_url: "/tmp/how_met_mother_large.jpg", category: comedy)
# Video.create(title: "The big bang theory", description: "The Big Bang Theory is an American sitcom created by Chuck Lorre and Bill Prady, both of whom serve as executive producers on the show along with Steven Molaro.", small_cover_url: "/tmp/the_theory.jpg", large_cover_url: "/tmp/the_theory_large.jpg", category: comedy)

# anton = User.create(full_name: "Anton Kolmakov", email: "anton@email.com", password: "secret")

# Review.create(user: anton, video: monk, rating: 5, content: "This is a really good movie.")
# Review.create(user: anton, video: monk, rating: 2, content: "This is a horrible good movie.")

User.create(full_name: "Anton Kolmakov", email: "anton@email.com", password: "secret", admin: true)