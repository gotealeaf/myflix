Fabricator(:invitation) do
  inviter { Fabricate(:user) }
  invitee_email { Faker::Internet.email }
  invitee_name { Faker::Name.name }
  message { Faker::Lorem.paragraph(2) }
end