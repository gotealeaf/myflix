Fabricator(:review) do
  rating { rand(1..5) }
  review { Faker::Lorem.paragraph(3) }
end
