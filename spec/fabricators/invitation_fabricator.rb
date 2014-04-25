Fabricator(:invitation) do 
  full_name { Faker::Name.name }
  email { Faker::Internet.email }
  message { Faker::Lorem.paragraph(sentence_count = 4) }
end

Fabricator(:bad_invitation, from: :invitation) do
  email { "" }
end