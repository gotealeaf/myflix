Fabricator(:invitation) do
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.email }
  inviter_id { 1 }
  message { Faker::Lorem.paragraph(3) }
end
