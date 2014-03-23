# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "Jake Gavin", email: "jakegavin@gmail.com", password: "jakegavin")
User.create(name: "Tristan Gavin", email: "tristan@gmail.com", password:"tristan")
User.create(name: "Shunei Asao", email: "shunei@gmail.com", password: "shunei" )
Video.create(title: "Archer", description: "Sophisticated spy Archer may have the coolest gadgets, but he still has issues when it comes to dealing with his boss -- who also is his mother.", small_cover_url: "/tmp/archer.jpg", large_cover_url: "/tmp/archer_large.jpg")
Video.create(title: "Breaking Bad", description: "A high school chemistry teacher dying of cancer teams with a former student to manufacture and sell crystal meth to secure his family's future.", small_cover_url: "/tmp/breaking_bad.jpg", large_cover_url: "/tmp/breaking_bad_large.jpg")
Video.create(title: "Family Guy", description: "In Seth MacFarlane's no-holds-barred animated show, buffoonish Peter Griffin and his dysfunctional family experience wacky misadventures.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy_large.jpg")
Video.create(title: "How I Met Your Mother", description: "Ted's epic search for his soul mate is told largely through flashbacks, as an adult Ted recounts to his kids how he met their mother.", small_cover_url: "/tmp/himym.jpg", large_cover_url: "/tmp/himym_large.jpg")
Video.create(title: "It's Always Sunny in Philadelphia", description: "Four narcissistic friends run a Philadelphia bar where their juvenile behavior brings situations from uncomfortable to hysterically horrible.", small_cover_url: "/tmp/iasip.jpg", large_cover_url: "/tmp/iasip_large.jpg")
Video.create(title: "New Girl", description: "Still rebounding from a breakup, Jessica Day moves in with three single guys, all of whom are ready to help her understand the ways of the world.", small_cover_url: "/tmp/new_girl.jpg", large_cover_url: "/tmp/new_girl_large.jpg")
Video.create(title: "Futurama", description: "A pizza delivery boy awakens in the 31st century after 1,000 years of cryogenic preservation and finds a job at an interplanetary delivery service.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama_large.jpg")
Video.create(title: "Monk", description: "Adrian Monk was a brilliant detective for the San Francisco Police Department until his wife, Trudy, was killed by a car bomb in a parking garage, which Monk then believed was intended for him.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Lost", description: "After their plane crashes on a deserted island, a diverse group of people must adapt to their new home and contend with the island's enigmatic forces.", small_cover_url: "/tmp/lost.jpg", large_cover_url: "/tmp/lost_large.jpg")
Video.create(title: "Parks and Recreation", description: "In this droll comedy, an employee with a rural Parks and Recreation department is full of energy and good ideas but bogged down by bureaucracy.", small_cover_url: "/tmp/parks_and_recreation.jpg", large_cover_url: "/tmp/parks_and_recreation.jpg")
Category.create(name: "Action & Adventure")
Category.create(name: "Comedy")
Category.create(name: "Drama")
Category.create(name: "Sci-Fi")
VideoCategory.create(category_id: 1, video_id: 6)
VideoCategory.create(category_id: 1, video_id: 2)
VideoCategory.create(category_id: 1, video_id: 8)
VideoCategory.create(category_id: 1, video_id: 4)
VideoCategory.create(category_id: 2, video_id: 1)
VideoCategory.create(category_id: 2, video_id: 2)
VideoCategory.create(category_id: 2, video_id: 3)
VideoCategory.create(category_id: 2, video_id: 4)
VideoCategory.create(category_id: 2, video_id: 5)
VideoCategory.create(category_id: 2, video_id: 6)
VideoCategory.create(category_id: 2, video_id: 7)
VideoCategory.create(category_id: 2, video_id: 8)
VideoCategory.create(category_id: 3, video_id: 7)
VideoCategory.create(category_id: 3, video_id: 3)
VideoCategory.create(category_id: 3, video_id: 5)
VideoCategory.create(category_id: 3, video_id: 4)
VideoCategory.create(category_id: 3, video_id: 1)
VideoCategory.create(category_id: 3, video_id: 8)
VideoCategory.create(category_id: 4, video_id: 1)
VideoCategory.create(category_id: 4, video_id: 7)
VideoCategory.create(category_id: 4, video_id: 6)
VideoCategory.create(category_id: 4, video_id: 2)
VideoCategory.create(category_id: 4, video_id: 3)
VideoCategory.create(category_id: 4, video_id: 8)
VideoCategory.create(category_id: 2, video_id: 9)
VideoCategory.create(category_id: 4, video_id: 9)
VideoCategory.create(category_id: 1, video_id: 9)
VideoCategory.create(category_id: 2, video_id: 10)
VideoCategory.create(category_id: 3, video_id: 10)
VideoCategory.create(category_id: 4, video_id: 10)
50.times do 
  Review.create(video_id: rand(Video.first.id..Video.last.id), user_id: rand(User.first.id..User.last.id), rating: rand(1..5), review: Faker::Lorem.paragraph)
end
User.all.each do |user|
  5.times do |index|
    QueueItem.create(user_id: user.id, video_id: rand(Video.first.id..Video.last.id), position: index+1)
  end
end