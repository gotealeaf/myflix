Fabricator(:video) do 
  title { Faker::Lorem.words(3).join(" ") }
  description { Faker::Lorem.words(6).join(" ") }
end