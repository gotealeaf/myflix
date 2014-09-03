# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
education = Category.create(name: "Education")
comedy  = Category.create(name: "Comedy")
action = Category.create(name: "Action")
monk = Video.create(title: 'Monk', description: 'A video about Monk', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg', category: comedy)
Video.create(title: 'The Daily Show', description: 'The Daily Show with Jon Stewart', small_cover_url: '/tmp/daily_show.jpeg', large_cover_url: '/temp/daily_show.jpeg', category: comedy)
Video.create(title: 'Frontline', description: 'A documentary show about things', small_cover_url: '/tmp/frontline.jpeg', large_cover_url: '/tmp/frontline.jpeg', category: education)
Video.create(title: 'Run Lola Run', description: 'German groundhog day', small_cover_url: '/tmp/run_lola_run.jpeg', large_cover_url: '/tmp/run_lola_run.jpeg', category: action)
Video.create(title: 'Equilibrium', description: 'Action-packed dystopian philosophy movie', small_cover_url: '/tmp/equilibrium.jpeg', large_cover_url: '/tmp/equilibrium.jpeg', category: action)
Video.create(title: 'Mindwalk', description: 'Philosophy movie presented in the socratic tradition', small_cover_url: '/tmp/mindwalk.jpeg', large_cover_url: '/tmp/mindwalk.jpeg', category: education)
Video.create(title: 'Sherlock', description: 'Modern mystery series', small_cover_url: '/tmp/sherlock.jpeg', large_cover_url: '/tmp/sherlock.jpeg', category: action)
Video.create(title: 'Family Guy', description: 'Disfunctional family animated comedy', small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/family_guy.jpg', category: comedy)
Video.create(title: 'Futurama', description: 'Futuristic animated comedy', small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama.jpg', category: comedy)
Video.create(title: 'Shaolin Temple Strikes Back!', description: 'The best kung fu movie ever.', small_cover_url: '/tmp/shaolin_temple_strikes_back.jpeg', large_cover_url: '/tmp/shaolin_temple_strikes_back.jpeg', category: action)
Video.create(title: 'South Park', description: 'Animated comedy', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/south_park.jpg', category: comedy)
Video.create(title: 'Futurama', description: 'Futuristic animated comedy', small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama.jpg', category: comedy)
Video.create(title: 'Shaolin Temple Strikes Back!', description: 'The best kung fu movie ever.', small_cover_url: '/tmp/shaolin_temple_strikes_back.jpeg', large_cover_url: '/tmp/shaolin_temple_strikes_back.jpeg', category: action)
Video.create(title: 'South Park', description: 'Animated comedy', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/south_park.jpg', category: comedy)

josh = User.create(full_name: "Josh Hunter", password: "password", email: "email@josh.com")

Review.create(user: josh, video: monk, rating: 5, content: "A good show")
Review.create(user: josh, video: monk, rating: 2, content: "Not great")
