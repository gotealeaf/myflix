Fabricator(:invitation) do
  recipient_email {Faker::Internet.email }
  recipient_name {Faker::Lorem.words(2).join(" ")}
  message {Faker::Lorem.words(10).join(" ")}
#invitee must be provided
end
