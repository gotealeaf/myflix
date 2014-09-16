require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do

    comedies = Fabricate(:category) 
    monk = Fabricate(:video, title: "Monk", category: comedies)
    futurama = Fabricate(:video, title: "Futurama", category: comedies)
    south_park = Fabricate(:video, title: "South Park", category: comedies)

    sign_in
    click_on_video_on_home_page(monk)
    page.should have_content(monk.title)  

    click_link "+ My Queue"
    page.should have_content(monk.title)

    visit video_path(monk)
    page.should_not have_content "+ My Queue"

    visit home_path
    click_on_video_on_home_page(south_park)
    click_link "+ My Queue"
    visit home_path
    click_on_video_on_home_page(futurama)
    click_link "+ My Queue"

    fill_in "video_#{monk.id}", with: 3
    fill_in "video_#{south_park.id}", with: 1
    fill_in "video_#{futurama.id}", with: 2

    click_button "Update Instant Queue"

    find("#video_#{south_park.id}").value.should == "1"
    find("#video_#{futurama.id}").value.should == "2"
    find("#video_#{monk.id}").value.should == "3"
    

  end 
end