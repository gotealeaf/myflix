Fabricator(:user) do
  password_1 = Faker::Lorem.word
  email { Faker::Internet.email }
  password { 'password' }
  password_confirmation { 'password' }
  full_name { Faker::Name.name }
end