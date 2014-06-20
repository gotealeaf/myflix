Fabricator(:video) do
  title { Faker::Lorem.words(3).join(" ")}
  description { Faker::Lorem.paragraph(1) }
end