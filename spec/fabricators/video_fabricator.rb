Fabricator(:video) do
  title { "Future" + Faker::Lorem.word }
  description { Faker::Lorem.sentence(6) }
end