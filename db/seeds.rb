# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: 'Star Wars', description: 'A classic about fighting in space', small_cover_url: 'tmp/starwarssm.jpg', large_cover_url: 'tmp/starwarslg.jpg')
Video.create(title: 'Star Trek', description: 'A wanna be classic about space', small_cover_url: 'tmp/startreksm.jpg', large_cover_url: 'tmp/startreklg.jpg')
Video.create(title: 'Rush', description: 'A thriller about F-1 racing', small_cover_url: 'tmp/rushsm.jpg', large_cover_url: 'tmp/rushlg.jpg')
Video.create(title: 'Casper', description: 'A classic ghost story', small_cover_url: 'tmp/caspersm.jpg', large_cover_url: 'tmp/casperlg.jpg')
Video.create(title: 'Gravity', description: 'A film about the future', small_cover_url: 'tmp/gravitysm.jpg', large_cover_url: 'tmp/gravitylg.jpg')
