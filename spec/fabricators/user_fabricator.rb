Fabricator(:user) do
  password_1 = Faker::Lorem.word
  email { Faker::Internet.email }
  password { password_1 }
  password_confirmation { password_1 }
  full_name { Faker::Name.name }
end