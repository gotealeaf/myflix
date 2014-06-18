Fabricator(:user) do
  email {Faker::Internet.email}
  password 'password'
  username {Faker::Name.name}
end