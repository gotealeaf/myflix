require 'spec_helper'

feature "Admin adds video" do 
  scenario "admin adds video and user plays it" do
    alice = Fabricate(:admin)
    bob = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate.build(:video)

    sign_in_user(alice)
    visit_add_video_page
    add_video(video, category)
    sign_out_user(alice)
    sign_in_user(bob)
    video = Video.first
    expect_admin_options_to_be_disabled(bob)
    expect_video_link_to_be_available(video)
  end
end

def visit_add_video_page
  expect(page).to have_content("Add Video")
  click_link "Add Video"
  expect(page).to have_content("Add a New Video")
end

def add_video(video, category)
  fill_in "Title", with: video.title
  expect(page).to have_content("Category")
  select "#{category.name}", from: "Category"
  fill_in "Description", with: video.description
  attach_file "Large Cover", "#{Rails.root}/spec/support/uploads/24_large.jpg"
  attach_file "Small Cover", "#{Rails.root}/spec/support/uploads/24.jpg"
  fill_in "Video URL", with: video.video_url
  click_button "Add Video"
  expect(page).to have_content("The video #{video.title} has been saved!")
end

def expect_admin_options_to_be_disabled(user)
  expect(page).to have_content("Welcome, #{user.full_name}")
  expect(page).not_to have_content("Add Video")
end

def expect_video_link_to_be_available(video)
  find("a[href='/videos/#{video.id}']").click
  expect(page).to have_selector("img[src='/uploads/video/large_cover/#{video.id}/24_large.jpg']")
  expect(page).to have_link("Watch Now", href: video.video_url)
end