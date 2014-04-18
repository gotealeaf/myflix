Fabricator(:video) do 
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence(word_count = 4, random_words_to_add = 5) }
  category_id { rand(1..5) }
end