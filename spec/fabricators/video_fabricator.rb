Fabricator(:video) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.characters(20) }
  large_cover_image_url { Faker::Lorem.word }
  small_cover_image_url { Faker::Lorem.word }
  category { Category.create(name: Faker::Name.name) }
end
