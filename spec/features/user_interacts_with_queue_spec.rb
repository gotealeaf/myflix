require 'spec_helper'

feature "user interacts with queue" do
  scenario "user adds and reorders videos in queue" do
    comedies = Fabricate(:category)
    monk = Fabricate(:video, title:"Monk", category: comedies)
    chakde = Fabricate(:video, title:"Chak De", category: comedies)
    futurama = Fabricate(:video, title:"Futurama", category: comedies)

    sign_in

    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_to_not_be_seen("+ My Queue")

    add_video_to_queue(chakde)
    add_video_to_queue(futurama)


    #find("input[data-video-id='#{monk.id}']").set(3)  #in case of new attribute, the data has to be searched/find
    #find("input[data-video-id='#{chakde.id}']").set(1)
    #find("input[data-video-id='#{futurama.id}']").set(2)

    #fill_in "datavideo_#{monk.id}", with: 3           #capybara can automatically find the id field or label
    #fill_in "video_#{chakde.id}", with: 1
    #fill_in "video_#{futurama.id}", with: 2

    set_video_position(monk,3)
    set_video_position(chakde,1)
    set_video_position(futurama,2)
    
    click_button "Update Instant Queue"
    
    expect_video_position(chakde,1)
    expect_video_position(futurama,2)
    expect_video_position(monk,3)
    
    #expect(find(:xpath, "//tr[contains(., '#{chakde.title}')]//input[@type='text']").value).to eq("1")
    #expect(find(:xpath, "//tr[contains(., '#{futurama.title}')]//input[@type='text']").value).to eq("2")
    #expect(find(:xpath, "//tr[contains(., '#{monk.title}')]//input[@type='text']").value).to eq("3")



    #expect(find("input[data-video-id='#{futurama.id}']").value).to eq("2")
    #expect(find("input[data-video-id='#{monk.id}']").value).to eq("3")
    #expect(find("#video_#{futurama.id}").value).to eq("2")
    #expect(find("#video_#{monk.id}").value).to eq("3")


  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content(video.title)

  end

  def expect_link_to_not_be_seen(link_text)
    expect(page).to_not have_content(link_text)
  end

  def add_video_to_queue(video)
    visit home_path
    find_and_click_video_on_home_page(video)
    click_link "+ My Queue"
  end

  def expect_video_position(video, position)
       expect(find(:xpath, "//tr[contains(., '#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end


  end
end

 #scenario "click on my queue button on video show page to add to queue"
  #scenario "click on the video link on the my queue page to confirm the video title on show page"
  #scenario "my queue button is not present if the video is in the users queue"