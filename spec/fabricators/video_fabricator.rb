Fabricator(:video) do
  title { Faker::Lorem.characters(10) }
  description { Faker::Lorem.characters(20) }
  large_cover_image_url { Faker::Lorem.word }
  small_cover_image_url { Faker::Lorem.word }
  category { Category.create(name: Faker::Name.name) }
  token {}
end
