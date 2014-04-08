require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    category = Fabricate(:category)
    video1 = Fabricate(:video, title: 'video1', category: category)
    video2 = Fabricate(:video, title: 'video2', category: category)
    video3 = Fabricate(:video, title: 'video3', category: category)
    sign_in

    add_video_to_queue(video1)
    expect(page).to have_content video1.title

    visit video_path(video1)
    expect(page).not_to have_content "+ My Queue"

    add_video_to_queue(video2)
    add_video_to_queue(video3)

    set_video_position(video1,3)
    set_video_position(video2,1)
    set_video_position(video3,2)

    click_button 'Update Instant Queue'

    expect_video_position(video1,3)
    expect_video_position(video2,1)
    expect_video_position(video3,2)
  end

  def expect_video_position(video,position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end

  def set_video_position(video,position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page(video)
    click_link("+ My Queue")
  end
end
