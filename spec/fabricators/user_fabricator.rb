Fabricator(:user) do
  name {"#{Faker::Name.name}"}
  email { "#{Faker::Internet.safe_email}" }
  password { "password" }
  reviews
end
