Fabricator(:user) do
  full_name { Faker::Name.name }
  email { Faker::Internet.email }
  password 'password'
end