Fabricator(:video) do
  title { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(2) }
end

Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  name { Faker::Name.name }
end