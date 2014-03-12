Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name }
  admin false
  locked false
end

Fabricator(:admin, from: :user) do
  admin true
end