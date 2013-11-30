# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: 'Inception', description: "Dom Cobb is a skilled thief, the absolute best in the dangerous art of extraction, stealing valuable secrets from deep within the subconscious during the dream state, when the mind is at its most vulnerable.", 
	small_cover: '/tmp/inception.jpg', big_cover: '/tmp/inception_large.jpg')

Video.create(title: 'Rush', description: "Set against the sexy, glamorous golden age of Formula 1 racing in the 1970s, the film is based on the true story of a great sporting rivalry between handsome English playboy James Hunt (Hemsworth), and his methodical, brilliant opponent, Austrian driver Niki Lauda (Bruhl).", 
	small_cover: '/tmp/rush.jpg', big_cover: '/tmp/rush_large.jpg')

Video.create(title: 'The Dark Knight', description: "Batman raises the stakes in his war on crime. With the help of Lieutenant Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the city streets.", 
	small_cover: '/tmp/the_dark_knight.jpg', big_cover: '/tmp/the_dark_knight_large.jpg')

Video.create(title: 'The Matrix', description: "Thomas A. Anderson is a man living two lives. By day he is an average computer programmer and by night a hacker known as Neo. Neo has always questioned his reality, but the truth is far beyond his imagination.", 
	small_cover: '/tmp/the_matrix.jpg', big_cover: '/tmp/the_matrix_large.jpg')

Video.create(title: 'The Shawnshank Redemption', description: "Andy Dufresne is a young and successful banker whose life changes drastically when he is convicted and sentenced to life imprisonment for the murder of his wife and her lover. Set in the 1940's, the film shows how Andy, with the help of his friend Red, the prison entrepreneur, turns out to be a most unconventional prisoner.", 
	small_cover: '/tmp/the_shawnshank_redemption.jpg', big_cover: '/tmp/the_shawnshank_redemption_large.jpg')
