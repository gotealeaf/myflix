Fabricator(:review) do
  creator { Fabricate(:user) }
  video { Fabricate(:video) }
  rating { rand(6) }
  body { Faker::Lorem.words(5).join(' ') }
  video { Fabricate(:video) }
end
