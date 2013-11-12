Fabricator(:video) do
  title { Faker::Lorem.sentence(2) }
  description { Faker::Lorem.paragraph(2) }
end