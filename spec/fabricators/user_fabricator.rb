Fabricator(:user) do 
  email { Faker::Internet.email }
  passowrd { 'password'}
  full_name { Faker::Name.name} 
end