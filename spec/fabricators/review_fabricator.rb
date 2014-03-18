Fabricator(:review) do
  rating { rand(1..5) }
  comment { Faker::Lorem.sentence(3) }
  #user
  #video
end