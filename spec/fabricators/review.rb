Fabricator(:review) do
  video
  user
  rating { (1..5).to_a.sample }
  review_description { Faker::Lorem.paragraph }
end

