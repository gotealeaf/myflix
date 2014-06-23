Fabricator :invitation do
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.email }
  invitation_message { Faker::Lorem.paragraph(2) }  
end