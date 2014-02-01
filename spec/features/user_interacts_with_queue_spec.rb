require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do

    action = Fabricate(:category)
    kungfu = Fabricate(:video, title: "Kung Fu", category: action)
    panda = Fabricate(:video, title: "Panda", category: action)
    transformers = Fabricate(:video, title: "Transformers", category: action)

    sign_in

    add_video_to_queue(kungfu)

    expect_video_to_be_in_queue(kungfu) 

    visit video_path(kungfu)
    expect_link_not_to_be_seen("+ My Queue")
   
    add_video_to_queue(panda)
    add_video_to_queue(transformers)

    set_video_position(kungfu, 3) 
    set_video_position(panda, 1) 
    set_video_position(transformers, 2) 

    update_queue

    expect_video_position(panda, 1) 
    expect_video_position(transformers, 2) 
    expect_video_position(kungfu, 3) 


  end
  
  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page(video)
    click_link "+ My Queue"
  end

  def set_video_position(video, position)
    find("input[data-video-id='#{ video.id }']").set(position.to_s)
  end

  def expect_video_position(video, position)
    expect(find("input[data-video-id='#{ video.id }']").value).to eq(position.to_s)
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
end
