Fabricator(:review) do
  rating {rand(5)+1}
  review {Faker::Lorem.paragraph}
  user
  video
end

