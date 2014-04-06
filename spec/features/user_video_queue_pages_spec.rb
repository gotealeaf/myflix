require 'spec_helper'

feature "User Video Queue Pages Spec" do
  given!(:joe)   { Fabricate(:user                         ) }
  given!(:drama) { Fabricate(:category, name: "Drama"      ) }
  given!(:monk)  { Fabricate(:video, title: "monk", categories: [drama]) }
  given!(:initiald)  { Fabricate(:video, title: "initial d", categories: [drama]) }
  given!(:lie_to_me)  { Fabricate(:video, title: "lie to me", categories: [drama]) }
  given!(:castle)  { Fabricate(:video, title: "castle", categories: [drama]) }

  scenario "user signs in, adds videos to My Queue, checks video page, reorders queue positions" do
    # User signs in
    signin_user(joe)
    page.should have_content "Drama"

    # Clicks video from root path
    click_video_image_link(monk)
    page.should have_content "Write Review"

    # Clicks '+ My Queue' to add video to queue, which takes user to My Queue page
    click_link "+ My Queue"
    page.should have_content "List Order"

    # The My Queue page should now have video in on the page
    expect_video_in_queue(monk)

    # Clicking video link takes user back to video page where there is now no '+ My Queue' button
    click_video_image_link(monk)
    page.should have_content "Write Review"
    page.should_not have_link "+ My Queue"

    # User clicks MyFLiX link to go back to root page and add more videos
    click_link "MyFLiX"
    page.should have_content "Drama"

    # User adds three more videos to queue & ends up on the My Queue page with 4 items in queue
    add_video_to_queue(initiald )
    add_video_to_queue(lie_to_me)
    add_video_to_queue(castle   )
    verify_number_of_items_in_queue(4)

    # User reorders the position of the first two videos, clicks update, is redirected back to My Queue with updated positions
    expect_queue_position(monk,     "1")
    expect_queue_position(initiald, "2")
    fill_in_queue_position_input_box(monk, 2)
    fill_in_queue_position_input_box(initiald, 1)
    click_button "Update Instant Queue"
    body.should have_content "List Order"
    expect_queue_position(monk,     "2")
    expect_queue_position(initiald, "1")
  end
end

def add_video_to_queue(video)
  click_link "MyFLiX"
  find(:xpath, "//a[@href='/videos/#{video.id}']").click
  click_link "+ My Queue"
end

def expect_queue_position(video, position)
  expect(find("#position_for_video_id_#{video.id}").value).to eq("#{position}")
end

def expect_video_in_queue(video)
  page.should have_selector(:xpath, "//a[@href='/videos/#{video.id}']")
end

def fill_in_queue_position_input_box(video, number)
  fill_in "position_for_video_id_#{video.id}", with: "#{number}"
end
