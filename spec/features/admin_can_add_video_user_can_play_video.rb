require 'spec_helper'

feature "Admin can add videos" do 
  
  scenario "admin successfully adds a video" do 
    administrator = Fabricate(:user, admin: true)
    karen = Fabricate(:user, admin: false)
    Fabricate(:category, name: "Action")

    sign_in(administrator)
    visit new_admin_video_path
    page.should have_content "Add a New Video"

    fill_in "Title", with: "Fight Club"
    select "Action", from: "Category"
    fill_in "Description", with: "An action movie starring Brad Pitt"
    attach_file  "Large cover", "spec/support/uploads/fight_club_large.jpg"
    attach_file  "Small cover", "spec/support/uploads/fight_club.jpeg"
    fill_in "Video url", with: "https://www.youtube.com/watch?v=EyOB9f7r14o"
    click_button "Create Video"
    page.should have_content "has been added"

    sign_out
    sign_in(karen) 

    visit video_path(Video.first)
    # save_and_open_page
    page.should have_selector("img[src='/uploads/fight_club_large.jpg']")
    page.should have_selector("a[href='https://www.youtube.com/watch?v=EyOB9f7r14o']")

  end

end