Fabricator(:user) do
  email     { Faker::Internet.email }
  full_name { Faker.name }
  password  { Faker::Internet.password }
end
