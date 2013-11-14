Fabricator(:review) do
	video_id { Fabricate(:video).id }
	rating { rand(1..5) }
	description { Faker::Lorem.paragraph.to_s }
	user_id { Fabricate(:user).id }
end