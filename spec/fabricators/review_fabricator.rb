Fabricator(:review) do 
  rating { rand(1..5) }
  review_text { Faker::Lorem.paragraph(sentence_count = 4) }
  video_id { rand(1..10) }
  user_id { rand(1..10) }
end

Fabricator(:bad_review, from: :review) do
  review_text { "" }
end