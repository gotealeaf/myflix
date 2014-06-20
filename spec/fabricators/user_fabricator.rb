Fabricator(:user) do 
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  name { Faker::Name.name }
end