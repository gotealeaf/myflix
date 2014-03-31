Fabricator(:review) do
  rating { (1..5).to_a.sample }
  content { Faker::Lorem.paragraph(3) }
  video { Fabricate(:video) }
  user { Fabricate(:user) }
end