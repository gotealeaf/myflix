Fabricator(:video) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence(6) }
end