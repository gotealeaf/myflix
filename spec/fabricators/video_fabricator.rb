Fabricator(:video) do
  name { Faker::Lorem.words(5).join(' ') }
  description { Faker::Lorem.paragraph(2) }
end
