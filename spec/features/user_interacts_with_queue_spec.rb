require 'spec_helper'

feature "User interacts with the queue" do
	scenario "user adds and reorders videos in the queue" do
		
		drama = Fabricate(:category, name: "Drama")
		inception = Fabricate(:video, title: "Inception", category: drama)
		gravity = Fabricate(:video, title: "Gravity", category: drama)
		rush = Fabricate(:video, title: "Rush", category: drama)
		
		sign_in

		add_video_to_queue(inception)
		expect_video_to_be_in_queue(inception)

		visit video_path(inception)
		expect_link_not_to_be_seen("+ My Queue")

		add_video_to_queue(gravity)
		add_video_to_queue(rush)

		set_video_position(inception, 3)
		set_video_position(gravity, 1)
		set_video_position(rush, 2)
		update_queue

		expect_video_position(gravity, 1)
		expect_video_position(rush, 2)
		expect_video_position(inception, 3)
	end

	def expect_video_to_be_in_queue(video)
		page.should have_content(video.title)
	end

	def expect_link_not_to_be_seen(link_text)
		page.should_not have_content(link_text)
	end

	def update_queue
		click_button "Update Instant Queue"
	end

	def add_video_to_queue(video)
		visit home_path
		find("a[href='/videos/#{video.id}']").click
		click_link "+ My Queue"
	end

	def set_video_position(video, position)
		within(:xpath, "//tr[contains(.,'#{video.title}')]") do
			fill_in "queue_items[][position]", with: position
		end
	end

	def expect_video_position(video, position)
		expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)		
	end
end
