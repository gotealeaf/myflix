require 'spec_helper'

feature "Add video for user to view" do
  given!(:drama){ Fabricate(:category, name: "Drama") }
  given(:addy)  { Fabricate(:admin   ) }
  given(:joe)   { Fabricate(:user    ) }

  scenario "admin adds a video to the site and a user watches it" do
    signin_user(addy)
    visit new_admin_video_path
    page.should have_content "Add a New Video"

    admin_adds_new_video_through_form
    signout

    signin_user(joe)
    click_video_link

    page_has_video_image_and_link_to_video
  end
end

#"//tr[contains(.,'#{user.name}')]//a[@data-method='delete']"

def click_video_link
  find(:xpath, "//a[@href='/videos/1']").click
end

def page_has_video_image_and_link_to_video
  expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
  page.should have_content "Watch Now"
  page.should have_selector("a[href='http://www.example.com']")
end

def admin_adds_new_video_through_form
  fill_in "Title", with: "Monk"
  select "Drama", from: "Category"
  fill_in "Description", with: "Monk"
  attach_file "Large Cover", "spec/support/uploads/monk_large.jpg"
  attach_file "Small Cover", "spec/support/uploads/monk.jpg"
  fill_in "Video Url", with: "http://www.example.com"
  click_button "Add Video"
end
