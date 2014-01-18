Fabricator(:review) do
  body { Faker::Lorem.paragraphs(2).join(" ") }
  rating { rand(4) + 1 }
end