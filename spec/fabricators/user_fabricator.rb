Fabricator(:user) do 
  email { Faker::Internet.email }
  full_name { Faker::Name.name }
  password { Faker::Lorem.words(1).join("") }
  admin { false }
end