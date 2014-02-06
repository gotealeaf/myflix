Fabricator(:invitation) do
  recipient_name {Faker::Name.name}
  recipient_email {Faker::Internet.email}
  message {Faker::Lorem.paragraph}
  token {SecureRandom.urlsafe_base64}
end

