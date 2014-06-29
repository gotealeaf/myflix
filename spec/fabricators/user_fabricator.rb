Fabricator(:user) do
  username { Faker::Internet.user_name }
  full_name { Faker::Name.name }
  email { Faker::Internet.email }
  password 'password'
  password_confirmation 'password'
end
