Fabricator(:user) do
  fullname { Faker::Name.name }
  email { Faker::Internet.email }
  password "password"
end