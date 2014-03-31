Fabricator(:video) do
  title { "#{Faker::Lorem.words(2).join(" ")}" }
  description { "#{Faker::Lorem.words(5).join(" ")}" }
  categories

  Fabricator(:category) do
    name {"#{Faker::Lorem.words(1).to_s}"}
  end

  Fabricator(:user) do
    name {"#{Faker::Name.name}"}
    email { "#{Faker::Internet.safe_email}" }
    password { "password" }
  end
end

#THIS WAS IN A USERS_FABRICATOR.....
# Fabricator(:user) do
#   email { "#{Faker::Internet.safe_email}" }
#   password { "password" }
#   name { "#{Faker::Name.name}" }
# end
