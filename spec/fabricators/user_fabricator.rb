Fabricator(:user) do
  email {Faker::Internet.email }
  password {Faker::Internet.password}  
  full_name {Faker::Lorem.words(2).join(" ")}
end
