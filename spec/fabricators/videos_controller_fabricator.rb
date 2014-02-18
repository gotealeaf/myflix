Fabricator(:video) do
  title { Faker::Lorem.words(5) }
  description { Faker::Lorem.paragraphs(3) }
end
