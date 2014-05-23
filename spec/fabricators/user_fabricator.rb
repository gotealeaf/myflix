Fabricator(:user) do
  email     { Faker::Internet.email }
  password  'secret'
  full_name { Faker::Name.name }
end