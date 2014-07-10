Fabricator :user do
  email { Faker::Internet.email }
  password 'password'
  password_confirmation 'password'
  full_name { Faker::Name.name }
  admin false
end

Fabricator :admin, from: :user do
  admin true
end