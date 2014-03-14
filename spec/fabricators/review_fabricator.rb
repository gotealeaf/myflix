Fabricator(:review) do
  content { Faker::Lorem.paragraph(2) }
  rating { (1..5).to_a.sample }
end
