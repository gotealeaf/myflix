Fabricator(:video) do
  title { Faker::Lorem.words(1).join('') }
  description { Faker::Lorem.paragraphs(1).join('') }
  category_id { Fabricate(:category).id }
  small_cover_url { "https://dl.dropbox.com/s/vg4xrmvbgi10cpb/simpsons_small.png" }
  large_cover_url { "https://dl.dropbox.com/s/pqrs0i9b5bwiqs5/simpsons_large.jpg" }
end
