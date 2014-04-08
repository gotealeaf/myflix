Fabricator(:user) do
  fullname { Faker::Name.name }
  email { Faker::Internet.email }
  password 'password'
  active true
end

Fabricator(:admin, from: :user) do
  admin true
end
