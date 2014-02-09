# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drama = Category.create(name: 'Drama')
action = Category.create(name: 'Action')
animation = Category.create(name: 'Animation')
comedy = Category.create(name: 'Comedy')
thriller = Category.create(name: 'Thriller')
fantacy = Category.create(name: 'Fantasy')
romance = Category.create(name: 'Romance')
sci_fi = Category.create(name: 'Sci-Fi')
biography = Category.create(name: 'Biography')
adventure = Category.create(name: 'Adventure')

Video.create(title: 'Inception', description: "Dom Cobb is a skilled thief, the absolute best in the dangerous art of extraction, stealing valuable secrets from deep within the subconscious during the dream state, when the mind is at its most vulnerable.", 
	small_cover: '/tmp/inception.jpg', big_cover: '/tmp/inception_large.jpg', category: drama)

rush = Video.create(title: 'Rush', description: "Set against the sexy, glamorous golden age of Formula 1 racing in the 1970s, the film is based on the true story of a great sporting rivalry between handsome English playboy James Hunt (Hemsworth), and his methodical, brilliant opponent, Austrian driver Niki Lauda (Bruhl).", 
	small_cover: '/tmp/rush.jpg', big_cover: '/tmp/rush_large.jpg', category: action)

Video.create(title: 'The Dark Knight', description: "Batman raises the stakes in his war on crime. With the help of Lieutenant Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the city streets.", 
	small_cover: '/tmp/the_dark_knight.jpg', big_cover: '/tmp/the_dark_knight_large.jpg', category: action)

Video.create(title: 'Gravity', description: "Dr. Ryan Stone (Sandra Bullock) is a brilliant medical engineer on her first shuttle mission, with veteran astronaut Matt Kowalsky (George Clooney) in command of his last flight before retiring. But on a seemingly routine spacewalk, disaster strikes.", 
	small_cover: '/tmp/gravity.jpg', big_cover: '/tmp/gravity_large.jpg', category: sci_fi)

Video.create(title: 'Terminator2', description: "Almost 10 years have passed since the first cyborg called The Terminator tried to kill Sarah Connor and her unborn son, John Connor. John Connor, the future leader of the human resistance, is now a healthy young boy.", 
	small_cover: '/tmp/terminator2.jpg', big_cover: '/tmp/terminator2_large.jpg', category: sci_fi)

Video.create(title: 'The Matrix', description: "Thomas A. Anderson is a man living two lives. By day he is an average computer programmer and by night a hacker known as Neo. Neo has always questioned his reality, but the truth is far beyond his imagination.", 
	small_cover: '/tmp/the_matrix.jpg', big_cover: '/tmp/the_matrix_large.jpg', category: sci_fi)



Video.create(title: 'Gravity', description: "Dr. Ryan Stone (Sandra Bullock) is a brilliant medical engineer on her first shuttle mission, with veteran astronaut Matt Kowalsky (George Clooney) in command of his last flight before retiring. But on a seemingly routine spacewalk, disaster strikes.", 
	small_cover: '/tmp/gravity.jpg', big_cover: '/tmp/gravity_large.jpg', category: sci_fi)

Video.create(title: 'Terminator2', description: "Almost 10 years have passed since the first cyborg called The Terminator tried to kill Sarah Connor and her unborn son, John Connor. John Connor, the future leader of the human resistance, is now a healthy young boy.", 
	small_cover: '/tmp/terminator2.jpg', big_cover: '/tmp/terminator2_large.jpg', category: sci_fi)

Video.create(title: 'The Matrix', description: "Thomas A. Anderson is a man living two lives. By day he is an average computer programmer and by night a hacker known as Neo. Neo has always questioned his reality, but the truth is far beyond his imagination.", 
	small_cover: '/tmp/the_matrix.jpg', big_cover: '/tmp/the_matrix_large.jpg', category: sci_fi)

Video.create(title: 'Gravity', description: "Dr. Ryan Stone (Sandra Bullock) is a brilliant medical engineer on her first shuttle mission, with veteran astronaut Matt Kowalsky (George Clooney) in command of his last flight before retiring. But on a seemingly routine spacewalk, disaster strikes.", 
	small_cover: '/tmp/gravity.jpg', big_cover: '/tmp/gravity_large.jpg', category: sci_fi)

michael = User.create(email: "michael@gmail.com", password: "password", full_name: "Michael Huang")

Review.create(user: michael, video: rush, rating: 4, content: "This is a awesome movie!")
Review.create(user: michael, video: rush, rating: 2, content: "This is a horrible movie...")
