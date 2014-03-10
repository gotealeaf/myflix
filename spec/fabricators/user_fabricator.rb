Fabricator(:user) do
  email { Faker::Internet.email }
  full_name { Faker::Name.name}
  password { Faker::Lorem.sentence(word_count = 5) }
end
