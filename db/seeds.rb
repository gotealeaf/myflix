# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cat2 = Category.create(title: 'Animation', description: "This is for drawn shows." )
category = Category.create(title: 'Intense Shows', description: "This is for drawn shows." )
video1 = Video.create(title: "Simpsons", description: "The Simpson family are cartoon characters featured in the animated television series The Simpsons. The Simpsons are a nuclear family consisting of married couple Homer and Marge and their three children Bart, Lisa and Maggie.", small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg", category: cat2)
video2 = Video.create(title: "Futurama", description: "Futurama is a show about the future and when someone from the year 2000 get beamed into the future.", small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg", category: cat2)
Video.create(title: "Family Guy", description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often lampoon American culture..", small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg", category: cat2 )
Video.create(title: 'Vid 1', description: "This is a show about a family.", category: category, created_at: 9.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 2', description: "This is a show about a family.", category: category, created_at: 8.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 3', description: "This is a show about a family.", category: category, created_at: 7.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 3', description: "This is a show about a family.", category: category, created_at: 6.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 4', description: "This is a show about a family.", category: category, created_at: 5.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 41', description: "This is a show about a family.", category: category, created_at: 4.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 412', description: "This is a show about a family.", category: category, created_at: 3.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 4122', description: "This is a show about a family.", category: category, created_at: 2.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
Video.create(title: 'Vid 41223', description: "This is a show about a family.", category: category, created_at: 1.minutes.ago, small_cover_url: "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png", large_cover_url: "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg")
user = User.create(fullname: "Matthew", email: "matthew@gmail.com", password: "test")
review1 = Fabricate(:review, video_id: 1, user_id: 1)
review2 = Fabricate(:review, video_id: 1, user_id: 1)
review3 = Fabricate(:review, video_id: 1, user_id: 1)
