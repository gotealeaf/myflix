Fabricator(:video) do
  title { Faker::Lorem.words(5).to_s }
  description { Faker::Lorem.paragraph(2)}
end