Fabricator(:video) do
  title       { Faker::Lorem.words.join(" ") }
  description { Faker::Lorem.paragraph(2) }
end