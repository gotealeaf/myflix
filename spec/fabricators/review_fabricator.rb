Fabricator(:review) do  
  rating { 5 }
  body { Faker::Lorem.paragraph }
  user    
end