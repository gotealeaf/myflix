require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds adds and reorders videos in the queue" do
    action = Category.create(name: "Action")
    video1 = Fabricate(:video, title: "Video 1")
    video1.categories << action
    video2 = Fabricate(:video, title: "Video 2")
    video2.categories << action
    video3 = Fabricate(:video, title: "Video 3")
    video3.categories << action
    
    sign_in
    
    add_video_to_queue(video1)
    expect_video_to_be_in_queue(video1)
    
    click_link(video1.title)
    expect_link_not_to_be_seen("+ My Queue")
    
    add_video_to_queue(video2)
    add_video_to_queue(video3)
    
    set_video_position(video1, 3)
    set_video_position(video2, 1)
    set_video_position(video3, 2)
    
    update_queue
    
    expect_video_position(video1, 3)
    expect_video_position(video2, 1)
    expect_video_position(video3, 2)
  end
  
  def add_video_to_queue(video)
    click_link("MyFlix")
    find("a[href='/videos/#{video.id}']").click
    click_link("+ My Queue")
  end
  
  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end
  
  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
  
  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
  end
  
  def expect_link_not_to_be_seen(link_text)
    page.should_not have_content(link_text)
  end
  
  def update_queue
    click_button("Update Instant Queue")
  end
  
end