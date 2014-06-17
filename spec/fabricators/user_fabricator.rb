Fabricator(:user) do
  email { Faker::Internet.email }
  full_name { Faker::Name.name }
  password "password"
  password_confirmation "password"
end
