Fabricator(:review) do
  rating   { [1,2,3,4,5].sample.to_i }
  content  { "#{Faker::Lorem.words(5).join(" ")}" }
  user
  video
end
