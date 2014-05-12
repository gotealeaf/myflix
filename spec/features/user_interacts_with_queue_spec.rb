require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    comedy = Category.create(name: "comedy")
    #comedies = Fabricate(:category) # because on the home page, videos are ordered by category
    monk = Fabricate(:video, title: "Monk")
    futurama = Fabricate(:video, title: "Futurama")
    south_park = Fabricate(:video, title: "South Park")
    monk.categories << comedy
    futurama.categories << comedy
    south_park.categories << comedy
    
    sign_in_user
    
    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)
    
    visit video_path(monk)
    expect_link_not_to_be_seen("+ My Queue")
    
    add_video_to_queue(futurama)
    add_video_to_queue(south_park)
    
    # Change the order of the queue items. for that, we need either ids or names of the input fields
    
    # using data attributes
    # find("input[data-video-id='#{monk.id}']").set(3)
    set_video_position(monk, 3)
    set_video_position(futurama, 1)
    set_video_position(south_park, 2)
    
    # if done with ids, this is how the sample code looks like:
    #fill_in "video_#{monk.id}", with: 3
    
    # if done using xpath, this is how the sample code looks like:
    # within(:xpath, "//tr[contains(.,'#{monk.title}')]") do
    #  fill_in "queue_items[][position]", with: 3  
    
    update_queue
    
    # finding using data input:
    # expect(find("input[data-video-id='#{monk.id}']").value).to eq ("3")
    
    expect_video_position(monk, 3)
    expect_video_position(futurama, 1)
    expect_video_position(south_park, 2)
    
    # finding using id:
    # expect(find("video_#{monk.id}").value).to eq ("3")
    
    # finding using xpath:
    # expect(find(:xpath, "//tr[contains(.,'#{monk.title}')]//input[@type='text']").value).to eq("3")
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
    find("input[data-video-id='#{video.id}']").set(position)
  end

  def expect_video_position(video, position)
    expect(find("input[data-video-id='#{video.id}']").value).to eq (position)
  end
end