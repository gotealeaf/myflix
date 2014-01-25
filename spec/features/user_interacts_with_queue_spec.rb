require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    
    comedies = Category.create(name: "comedies")
    community = Fabricate(:video, name: "Community", category: comedies)
    fg = Fabricate(:video, name: "Family Guy", category: comedies)
    futurama = Fabricate(:video, name: "Futurama", category: comedies)
    
    sign_in

    add_video_to_queue(community)
    expect_video_to_be_in_queue(community)
    
    visit video_path(community)
    page.should_not have_content "+ My Queue"
    
    add_video_to_queue(fg)
    add_video_to_queue(futurama)

    set_video_position(community, 3)
    set_video_position(fg, 1)
    set_video_position(futurama, 2)
    
    click_button "Update instant queue"
    
    expect_video_position(fg, 1)
    expect_video_position(futurama, 2)
    expect_video_position(community, 3)
  end
  
  def expect_video_position(video, position)
     expect(find("input[data-video-id='#{video.id}']").value).to eq(position.to_s)
  end
  
  def set_video_position(video, position)
     find("input[data-video-id='#{video.id}']").set(position)
  end
  
  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end
  
  def expect_video_to_be_in_queue(video)
    page.should have_content(video.name)
  end
end