Fabricator(:review) do
  rating {rand(5)+1}
  content {Faker::Lorem.paragraph}
  user
  video
end

