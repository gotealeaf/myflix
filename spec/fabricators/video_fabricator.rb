Fabricator(:video) do
  title { Faker::Lorem.words(1).join }
  description { Faker::Lorem.words(5).join(" ") }
end