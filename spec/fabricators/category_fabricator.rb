Fabricator(:category) do
  name { Faker::Lorem.words(1).to_s }
end