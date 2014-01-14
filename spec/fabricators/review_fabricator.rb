Fabricator(:review) do
  rating {(1..5).to_a.sample}
  content {Faker::Lorem.sentences(3).to_s}
  user
  video

end

