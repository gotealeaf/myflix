Fabricator(:user) do
  email { Faker::Internet.email }
  full_name { Faker::Name.name }
  password { Faker::Lorem.characters(char_count = 15) }
end
