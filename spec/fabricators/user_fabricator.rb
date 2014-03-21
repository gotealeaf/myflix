Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.free_email }
  password { Faker::Internet.password }
end