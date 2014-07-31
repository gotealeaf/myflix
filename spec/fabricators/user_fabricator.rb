Fabricator(:user) do
  fullname { Faker::Name.name }
  email { Faker::Internet.email }
  password "password"
  password_reset_token { SecureRandom.urlsafe_base64 }
end