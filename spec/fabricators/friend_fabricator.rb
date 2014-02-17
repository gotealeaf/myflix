Fabricator(:friend) do
  full_name { Faker::Name.name }
  email { Faker::Internet.email }
  message { Faker::Lorem.paragraphs(2).join(" ") }
  user { Fabricate(:user) }
end