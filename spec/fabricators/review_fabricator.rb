Fabricator(:review) do
  rating { (1..5).to_a.sample }
  content { Faker::Lorem.paragraph(2) }
end