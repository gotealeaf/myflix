Fabricator(:user) do
  email { Faker::Internet.email }
  fullname { Faker::Name.first_name }
  password { Faker::Internet.email }
end
