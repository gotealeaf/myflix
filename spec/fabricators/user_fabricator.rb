Fabricator(:user) do
	fullname { Faker::Name.name }
	email { Faker::Internet.email}
	password { Faker::Lorem.words(1)}
end