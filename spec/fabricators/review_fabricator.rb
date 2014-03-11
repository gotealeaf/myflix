Fabricator(:review) do
  user_review { Faker::Lorem.paragraph(2) }
  
  
end