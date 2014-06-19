Fabricator(:review) do
  user { Fabricate(:user) }
  video { Fabricate(:video) }
  rating { (0..5).to_a.sample }
  content { Faker::Lorem.paragraph(2) }
end
