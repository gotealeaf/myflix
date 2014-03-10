Fabricator(:user) do
  email { Faker::Internet.email }
  full_name { Faker::Name.name }
  password { Faker::Internet.password }
end