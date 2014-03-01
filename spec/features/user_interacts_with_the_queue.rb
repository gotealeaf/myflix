require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
  	thriller = Fabricate(:category)
  	lost = Fabricate(:video, title: "Lost Highway", category: thriller)
  	inc = Fabricate(:video, title: "Inception", category: thriller)
  	drive = Fabricate(:video, title: "Drive", category: thriller)

    sign_in

    add_video_to_queue(lost)
    expect_video_to_be_in_queue(lost)

    visit video_path(lost)
    expect_link_not_to_be_seen("+ My Queue")
 
    add_video_to_queue(inc)
    add_video_to_queue(drive)
    
    set_video_position(lost, 3)
    set_video_position(inc, 1)
    set_video_position(drive, 2)
    update_queue

    expect_video_position(lost,3)
    expect_video_position(inc,1)
    expect_video_position(drive,2)

  end


  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page(video)
    click_link "+ My Queue"
  end

  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
  end

  def expect_link_not_to_be_seen(link_text)
    page.should_not have_content(link_text)
  end

  def set_video_position(video,position)
    find("input[data-video-id='#{video.id}']").set(position)
  end

  def update_queue
    click_button "Update Instant Queue"
  end

  def expect_video_position(video,position)
    expect(find("input[data-video-id='#{video.id}']").value).to eq(position.to_s)
  end
end