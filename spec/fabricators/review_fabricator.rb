Fabricator(:review) do
  video
  user

  rating { (1..5).to_a.sample }
  comment { Faker::Lorem.paragraph }
end
