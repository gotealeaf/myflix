require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    category1 = Fabricate(:category)
    video1 = Fabricate(:video, title: "Video 1", category_id: category1.id)
    video2 = Fabricate(:video, title: "Video 2", category_id: category1.id)
    video3 = Fabricate(:video, title: "Video 3", category_id: category1.id)

    alice = Fabricate(:user)
    sign_in_user(alice)
    
    add_video_to_queue(video1)
    expect_video_to_be_in_queue(video1)
    
    visit video_path(video1)
    expect_link_not_to_be_seen "+ My Queue"
    
    add_video_to_queue(video2)
    add_video_to_queue(video3)

    visit my_queue_path
    set_video_position(video1, 3)
    set_video_position(video2, 2)
    set_video_position(video3, 1)
    update_queue
    
    expect_video_position(video1, 3)
    expect_video_position(video2, 2)
    expect_video_position(video3, 1)
  end 
end

def expect_video_to_be_in_queue(video)
  expect(page).to have_content video.title
end

def expect_link_not_to_be_seen(link_text)
  expect(page).not_to have_content link_text
end

def add_video_to_queue(video)
  visit home_path
  find("a[href='/videos/#{video.id}']").click
  click_link "+ My Queue"
end

def update_queue
  click_button "Update Instant Queue"
end

def set_video_position(video, position)
  find("input[data-video-id='#{video.id}']").set(position)
end

def expect_video_position(video, position)
  expect(find("input[data-video-id='#{video.id}']").value).to eq "#{position}"
end