Fabricator(:review) do
  creator { Fabricate(:user) }
  video { Fabricate(:video) }
  rating { (1..5).to_a.sample }
  body { Faker::Lorem.words(5).join(' ') }
end
