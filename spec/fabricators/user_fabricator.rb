Fabricator(:user) do
  fullname { Faker::Name.name }
  email { Faker::Internet.email }
  password "password"
  token { SecureRandom.urlsafe_base64 }
end