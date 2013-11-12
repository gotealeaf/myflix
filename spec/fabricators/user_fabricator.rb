Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  password_confirmation 'password'
  full_name { Faker::Name.name }
end