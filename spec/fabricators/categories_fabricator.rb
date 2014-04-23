Fabricator(:category) do
  title { Faker::Lorem.words(1).join('') }
  description { Faker::Lorem.paragraphs(1).join('') }
end
