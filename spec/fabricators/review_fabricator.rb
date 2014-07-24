Fabricator(:review) do
  rating { rand(5) }
  content { Faker::Lorem.paragraph(3) }

end
