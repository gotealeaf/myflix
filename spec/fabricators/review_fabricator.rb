Fabricator(:review) do 
  rating { rand(1..5) }
  review_text { Faker::Lorem.paragraph(sentence_count = 4) }
  video_id { Faker::Number.digit }
  user_id { Faker::Number.digit }
end