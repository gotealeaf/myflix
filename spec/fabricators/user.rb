Fabricator(:user)  do
  name Faker::Name.name
  password Faker::Internet.password
end

Fabricator(:invalid_user, from: :user)  do
  name Faker::Name.name
  password ""
end
