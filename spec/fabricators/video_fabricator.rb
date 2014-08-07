Fabricator(:video) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.characters(20) }
  large_cover_image_url { Faker::Lorem.word }
  small_cover_image_url { Faker::Lorem.word }
  category_id 1
end
