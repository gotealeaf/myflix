# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: 'South Park', description: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo', small_cover_url: 'south_park')
Video.create(title: 'Futurama', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ', small_cover_url: 'futurama')
Video.create(title: 'South Park', description: 'Short Description. ', small_cover_url: 'south_park')
Video.create(title: 'Monk', description: 'Another short description', small_cover_url: 'monk')
Video.create(title: 'Futurama', description: 'Gibberish for the description -kdljfkljadfl dlkjf lkdajslfkj dlkj fjsd lkafdslkfjd . ', small_cover_url: 'futurama')

Category.create(name: 'Drama')
Category.create(name: 'Comedy')
Category.create(name: 'Reality TV')

Video.all.each do |video|
  video.category = Category.all.sample
  video.save 
end