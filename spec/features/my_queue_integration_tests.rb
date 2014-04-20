require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    mafia = Category.create(name: 'Mafia')
    # mafia = Fabricate :category
    the_wire = Fabricate :video, title: "The Wire", category: mafia
    the_sopranos = Fabricate :video, title: "The Sopranos", category: mafia
    purgatorio = Fabricate :video, title: "Purgatorio", category: mafia

    sign_in 

    add_video_to_queue the_wire
    expect_video_to_be_in_queue the_wire
  
    visit video_path the_wire
    expect_link_not_to_be_seen "+ My Queue"

    add_video_to_queue the_sopranos
    add_video_to_queue purgatorio
    
    set_video_position the_wire, 3
    set_video_position the_sopranos, 1
    set_video_position purgatorio, 2

    click_button "Update Instant Queue"

    expect_video_position the_sopranos, 1
    expect_video_position purgatorio, 2
    expect_video_position the_wire, 3
  end
end

def expect_video_to_be_in_queue video
  page.should have_content video.title
end

def expect_link_not_to_be_seen link_text
  page.should_not have_content link_text
end

def set_video_position video, position
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][order]", with: position
    end  
end

def expect_video_position video, position
  expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq("#{position}")
end

def add_video_to_queue video
  visit videos_path
  find("a[href='/videos/#{video.id}']").click
  click_button "+ My Queue"
end