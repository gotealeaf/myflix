Fabricator(:invitation) do
  user_id { Fabricate(:user).id }
  email { Faker::Internet.email }
  fullname { Faker::Name.first_name }
  status { "pending" }
  message { Faker::Lorem.paragraphs(1).join('') }
  invite_token { SecureRandom.urlsafe_base64 }
end
