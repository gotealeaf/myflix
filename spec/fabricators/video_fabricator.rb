Fabricator(:video) do
  title { Faker::Lorem.words(1).join }
  description { Faker::Lorem.words(5).join(" ") }
  small_cover { Faker::Lorem.words(1).join + ".jpeg" }
  category_id 1
end