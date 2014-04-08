Fabricator(:review) do
#  video
#  user { User.all.sample }
  rating { (1..5).to_a.sample }
  review_description { Faker::Lorem.paragraph }
end

