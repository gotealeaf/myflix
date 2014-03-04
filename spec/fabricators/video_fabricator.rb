Fabricator(:video) do
  description { Faker::Lorem.paragraph(2).join(" ") }
  title { Faker::Lorem.words(3) }
  category
  
end