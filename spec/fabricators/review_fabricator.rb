Fabricator(:review) do
  video { Fabricate(:video) }
  user { Fabricate(:user) }
  rating { rand(1..5) }
  text { Faker::Lorem.paragraph }
end