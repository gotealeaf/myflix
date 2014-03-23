Fabricator(:review) do
  video { Fabricate(:video) }
  user { Fabricate(:user) }
  rating { rand(1..5) }
  review { Faker::Lorem.paragraph }
end