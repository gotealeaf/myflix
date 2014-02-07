Fabricator(:video) do
  title { Faker::Lorem.words(2..4).map(&:capitalize).join(" ") }
  description { Faker::Lorem.paragraph(2) }
end
