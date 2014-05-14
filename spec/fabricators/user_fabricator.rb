Fabricator(:user) do
  email { Faker::Internet.email }
  full_name { Faker::Name.name }
  password { Faker::Lorem.characters(char_count = 15) }
  admin { false }
end

Fabricator(:bad_user, from: :user) do
  email { "" }
end

Fabricator(:admin, from: :user) do 
  admin { true }
end
