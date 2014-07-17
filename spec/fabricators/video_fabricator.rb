Fabricator(:video) do
  title { Faker::Lorem.words(1).join }
  description { Faker::Lorem.words(5).join(" ") }
  small_cover_url { Faker::Lorem.words(1).join + ".jpeg" }
end