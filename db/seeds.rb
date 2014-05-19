# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedy = Category.create({name: 'TV Comedies'})
drama = Category.create({name: 'TV Dramas'})

3.times do |num|
  Video.create([{title: "South Park #{num}", description: 'South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network.',
               small_cover_url: 'covers/south_park.jpg', large_cover_url: 'covers/south_park_large.jpg', category: comedy},
              {title: "Family Guy #{num}", description: 'Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company',
               small_cover_url: 'covers/family_guy.jpg', large_cover_url: 'covers/family_guy_large.jpg', category: comedy},
              {title: "Futurama #{num}",  description: 'Futurama is an American adult animated science fiction sitcom created by Matt Groening and developed by Groening and David X. Cohen for the Fox Broadcasting Company',
               small_cover_url: 'covers/futurama.jpg', large_cover_url: 'covers/futurama_large.jpg', category: comedy},
              {title: "Monk #{num}",  description: 'Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk.',
               small_cover_url: 'covers/monk.jpg', large_cover_url: 'covers/monk_large.jpg', category: drama}])
end

user1 = User.create(email: 'rebert@critics.com', full_name: 'Roger Ebert', password: 'secret')
user2 = User.create(email: 'wshatner@stars.com', full_name: 'William Shatner', password: 'secret')
user3 = User.create(email: 'jdoe@public.com', full_name: 'John Doe', password: 'secret')

futurama1 = Video.search_by_title("Futurama 1").first

Review.create(video: futurama1, user: user1, rating: 2, content: "This is the text of the first review. Critics panned this episode.")
Review.create(video: futurama1, user: user2, rating: 5, content: "This is the text of the second review.  William Shatner loves Futurama")
Review.create(video: futurama1, user: user3, rating: 4, content: "This is the text of the last review. The general public enjoyed it.")
