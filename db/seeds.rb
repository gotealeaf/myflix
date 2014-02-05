# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedy = Category.create(name: 'Comedies')
drama = Category.create(name: 'Drama')
sci_fi = Category.create(name: 'Sci-fi')
action = Category.create(name: 'Action')

south_park = Video.create(title: 'South Park Season 1', description: 'An awesome show about 4 young boys...', small_cover_url: 'south_park.jpg', large_cover_url: 'south_park_large.jpg', category: comedy)
Video.create(title: 'South Park Season 2', description: 'An awesome show about 4 young boys...', small_cover_url: 'south_park.jpg', large_cover_url: 'south_park_large.jpg', category: comedy)
Video.create(title: 'South Park Season 3', description: 'An awesome show about 4 young boys...', small_cover_url: 'south_park.jpg', large_cover_url: 'south_park_large.jpg', category: comedy)
Video.create(title: 'South Park Season 4', description: 'An awesome show about 4 young boys...', small_cover_url: 'south_park.jpg', large_cover_url: 'south_park_large.jpg', category: comedy)
Video.create(title: 'South Park Season 5', description: 'An awesome show about 4 young boys...', small_cover_url: 'south_park.jpg', large_cover_url: 'south_park_large.jpg', category: comedy)
Video.create(title: 'South Park Season 6', description: 'An awesome show about 4 young boys...', small_cover_url: 'south_park.jpg', large_cover_url: 'south_park_large.jpg', category: comedy)
Video.create(title: 'Futurama Season 1', description: 'An awesome movie about people from the future...', small_cover_url: 'futurama.jpg', large_cover_url: 'futurama_large.jpg', category: sci_fi)
Video.create(title: 'Futurama Season 2', description: 'An awesome movie about people from the future...', small_cover_url: 'futurama.jpg', large_cover_url: 'futurama_large.jpg', category: sci_fi)
Video.create(title: 'Futurama Season 3', description: 'An awesome movie about people from the future...', small_cover_url: 'futurama.jpg', large_cover_url: 'futurama_large.jpg', category: sci_fi)
Video.create(title: 'Futurama Season 4', description: 'An awesome movie about people from the future...', small_cover_url: 'futurama.jpg', large_cover_url: 'futurama_large.jpg', category: sci_fi)
Video.create(title: 'Futurama Season 5', description: 'An awesome movie about people from the future...', small_cover_url: 'futurama.jpg', large_cover_url: 'futurama_large.jpg', category: sci_fi)
Video.create(title: 'Futurama Season 6', description: 'An awesome movie about people from the future...', small_cover_url: 'futurama.jpg', large_cover_url: 'futurama_large.jpg', category: sci_fi)
Video.create(title: 'Monk Season 1', description: 'About some deutchebag...', small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: action)
Video.create(title: 'Monk Season 2', description: 'About some deutchebag...', small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: action)
Video.create(title: 'Monk Season 3', description: 'About some deutchebag...', small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: action)
Video.create(title: 'Monk Season 4', description: 'About some deutchebag...', small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: action)
Video.create(title: 'Monk Season 5', description: 'About some deutchebag...', small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: action)
Video.create(title: 'Monk Season 6', description: 'About some deutchebag...', small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: action)
Video.create(title: 'Family Guy Season 1', description: 'About an all but normal family...', small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy_large.jpg', category: drama)
Video.create(title: 'Family Guy Season 2', description: 'About an all but normal family...', small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy_large.jpg', category: drama)
Video.create(title: 'Family Guy Season 3', description: 'About an all but normal family...', small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy_large.jpg', category: drama)
Video.create(title: 'Family Guy Season 4', description: 'About an all but normal family...', small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy_large.jpg', category: drama)
Video.create(title: 'Family Guy Season 5', description: 'About an all but normal family...', small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy_large.jpg', category: drama)
Video.create(title: 'Family Guy Season 6', description: 'About an all but normal family...', small_cover_url: 'family_guy.jpg', large_cover_url: 'family_guy_large.jpg', category: drama)

Video.create(title: 'Money', description: 'this guys sucks', small_cover_url: 'monk.jpg', large_cover_url: 'monk_large.jpg', category: comedy)

santa = User.create(full_name: "Santa Claus", password: "password", email: "santa@northpole.com")
Review.create(user: santa, video: south_park, rating: 3, content: "This is a really good show.")
Review.create(user: santa, video: south_park, rating: 4, content: "The funniest show never.")










