Fabricator(:review) do
  rating { (1..5).to_a.sample } #will show random number between 1 to 5
  content { Faker::Lorem.paragraph(2) }
end