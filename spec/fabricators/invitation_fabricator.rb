Fabricator(:invitation) do 
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.email }
  message { Faker::Lorem.paragraph(sentence_count = 4) }
end

Fabricator(:bad_invitation, from: :invitation) do
  recipient_email { "" }
end