Fabricator :review do
  rating { (1..5).to_a.sample }
  content { Faker::Lorem.paragraph(3) }
  user_id { (1..100).to_a.sample }
  video_id { (1..100).to_a.sample }
end