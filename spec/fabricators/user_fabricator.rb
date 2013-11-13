Fabricator(:user) do
  email_address { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name }
end