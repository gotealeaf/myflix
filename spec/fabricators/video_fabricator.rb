Fabricator(:video) do 
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence(word_count = 4, random_words_to_add = 5) }
  category_id { rand(1..5) }
  video_url { Faker::Internet.url('example.com') }
end

Fabricator(:bad_video, from: :video) do
  title { "" }
end