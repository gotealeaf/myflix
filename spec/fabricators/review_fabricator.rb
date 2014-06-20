Fabricator(:review) do
  body { Faker::Lorem.words(10).join(" ") }
  rating { rand(1..5) }
end