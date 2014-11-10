Fabricator(:invitation) do
  friend_email { Faker::Internet.email }
end