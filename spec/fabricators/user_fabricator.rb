Fabricator(:user) do
  email { Faker::Internet.email }  
  name { Faker::Name.name }
  password {'12345'}
end