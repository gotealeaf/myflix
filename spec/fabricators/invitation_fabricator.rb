Fabricator(:invitation) do
  friend_name  { "#{Faker::Name.name}" }
  friend_email { "#{Faker::Internet.safe_email}" }
  message      { "#{Faker::Lorem.words(5)}" }
end
