Fabricator(:invitation) do
  inviter_id {[1,2,3,4,5].sample}
  guest_email {Faker::Internet.email}
  guest_name {Faker::Name.name}
  message {Faker::Lorem.sentence}
end