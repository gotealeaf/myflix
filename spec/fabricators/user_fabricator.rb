Fabricator(:user) do 
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name }
  token '12345' 
  admin false
end

Fabricator(:admin, from: :user) do
  admin true
end
