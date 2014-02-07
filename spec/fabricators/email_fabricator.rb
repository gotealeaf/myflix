Fabricator(:email) do
  name { Faker::Internet.email }
end