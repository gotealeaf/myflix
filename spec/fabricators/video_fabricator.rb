Fabricator(:video) do
  description { Faker::Lorem.paragraph(2).to_s }
  title { Faker::Lorem.words(3).to_s }
  category
  
end