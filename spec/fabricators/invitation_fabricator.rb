Fabricator(:invitation) do
	recipient_name { Faker::Name.name.to_s }
	recipient_email { Faker::Internet.email }
	message { Faker::Lorem.paragraph(2) }
end