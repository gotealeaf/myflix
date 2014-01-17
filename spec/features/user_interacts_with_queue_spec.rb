require 'spec_helper'

feature "User interacts with the queue" do
	scenario "User adds and reorders videos in the queue" do
		comedies = Fabricate(:category)
		monk = Fabricate(:video, title: "Monk", category: comedies)
		south_park = Fabricate(:video, title: "South Park", category: comedies)
		futurama = Fabricate(:video, title: "Futurama", category: comedies)

		sign_in

		add_video_to_queue(monk)
		page.should have_content(monk.title)

		visit video_path(monk)
		page.should_not have_content "+ My Queue"

		add_video_to_queue(south_park)
		add_video_to_queue(futurama)

		set_video_position(monk, 3)
		set_video_position(south_park, 1)
		set_video_position(futurama, 2)

		click_button "Update Instant Queue"

		expect_video_position(south_park, 1)
		expect_video_position(futurama, 2)
		expect_video_position(monk, 3)
	end

	def add_video_to_queue(video)
		visit home_path
		find("a[href='/videos/#{video.id}']").click
		click_link "+ My Queue"
	end

	def set_video_position(video, position)
		find("input[data-video-id='#{video.id}']").set(position)
	end

	def expect_video_position(video, position)
		expect(find("input[data-video-id='#{video.id}']").value).to eq(position.to_s)
	end
end