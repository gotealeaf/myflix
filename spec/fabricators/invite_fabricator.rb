Fabricator(:invite) do
  friend_email { Faker::Internet.email }
  friend_name { Faker::Name.name }
end