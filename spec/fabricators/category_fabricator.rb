Fabricator(:category) do
  name { Faker::Lorem.words(2).to_s }
end
