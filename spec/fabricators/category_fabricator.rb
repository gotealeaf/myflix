Fabricator(:category) do
  name { Faker::Lorem.words(1).join }
end