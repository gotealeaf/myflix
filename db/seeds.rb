Category.destroy_all

comedy = Category.create(name: "TV Comedies")
drama = Category.create(name: "TV Dramas")
reality_tv = Category.create(name: "Reality TV")


Video.destroy_all
v1 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)
v2 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
v3 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 3.day.ago)
v4 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 4.day.ago)
v5 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 5.day.ago)
v6 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 6.day.ago)
v7 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 7.day.ago)
v8 = Video.create(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: comedy.id, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 8.day.ago)

south_park = Video.create(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: drama.id, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)


v11 = Video.create(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: reality_tv.id, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)
v12 = Video.create(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: reality_tv.id, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
v13 = Video.create(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: reality_tv.id, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 3.day.ago)
v14 = Video.create(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: reality_tv.id, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 4.day.ago)


User.destroy_all
alice = User.create(full_name: "alice", password: "password", email: "alice@example.com")
bob = User.create(full_name: "bob", password: "password", email: "bob@example.com")



Review.destroy_all
Review.create(user_id: bob.id, video_id: south_park.id, rating: 5.0, content: "boy o boy what film!")
Review.create(user_id: alice.id, video_id: south_park.id, rating: 2.0, content: "not so good!")


=begin
videos = Video.all
videos.each do |video|
  review_array.each do |review|
    video.reviews << review
  end
end

Video.destroy_all

Fabricate(:video)

v1 = Fabricate(:video)
v2 = Fabricate(:video)
v3 = Fabricate(:video)
v4 = Fabricate(:video)
v5 = Fabricate(:video)
v6 = Fabricate(:video)
v7 = Fabricate(:video)
v8 = Fabricate(:video)
v9 = Fabricate(:video)
v10 = Fabricate(:video)
v11 = Fabricate(:video)
v12 = Fabricate(:video)
v13 = Fabricate(:video)
v14 = Fabricate(:video)

Review.destroy_all

Fabricate(:review, rating: 2.0, video_id: v1)
Fabricate(:review, rating: 4.0, video_id: v2)
Fabricate(:review, rating: 5.0, video_id: v3)
Fabricate(:review, rating: 4.0, video_id: v4)
Fabricate(:review, rating: 3.0, video_id: v5)
Fabricate(:review, rating: 3.0, video_id: v6)
Fabricate(:review, rating: 2.0, video_id: v7)
Fabricate(:review, rating: 4.0, video_id: v8)
Fabricate(:review, rating: 4.0, video_id: v9)
Fabricate(:review, rating: 3.0, video_id: v10)
Fabricate(:review, rating: 2.0, video_id: v11)
Fabricate(:review, rating: 5.0, video_id: v12)
Fabricate(:review, rating: 5.0, video_id: v13)
Fabricate(:review, rating: 1.0, video_id: v14)

#v10, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14)


v1 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)
v2 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
v3 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 3.day.ago)
v4 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 4.day.ago)
v5 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 5.day.ago)
v6 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 6.day.ago)
v7 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 7.day.ago)
v8 = Video.create!(title: "Futurama", description: "An awesome, nerdy spin off of the Simpsons ...", category_id: 1, small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 8.day.ago)

v9 = Video.create!(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: 2, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
v10 = Video.create!(title: "South Park", description: "A show with crude language and dark surreal humor...", category_id: 2, small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)

v11 = Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 1.day.ago)
v12 = Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 2.day.ago)
v13 = Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 3.day.ago)
v14 = Video.create!(title: "Family Guy", description: "A cartoon that exhibits much of its humor in the form of cutaway gags...", category_id: 3, small_cover: "/tmp/family_guy.jpg", large_cover: "/tmp/monk_large.jpg", created_at: 4.day.ago)
=end



