Fabricator(:video) do
  description { Faker::Lorem.paragraph(2) }
  title { Faker::Lorem.words(3) }
  category
  
end