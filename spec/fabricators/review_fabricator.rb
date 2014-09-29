Fabricator(:review) do
  rating {1 + rand(5)}
  description {Faker::Lorem.words(10).join(" ")}
  user
  video 
end
