require 'spec_helper'

feature "admin uploads new videos" do
  scenario "successfully uploads video and it is searchable by users" do
    admin = Fabricate(:admin)
    drama = Fabricate(:category, name: "Drama")
    
    sign_in_user(admin)
    
    visit new_admin_video_path
    
    fill_in "Title", with: "Monk"
    check "video_category_ids_1"
    fill_in "Description", with: "An engaging story"
    attach_file "Large Cover", "spec/support/uploads/monk_large.jpg"
    attach_file "Small Cover", "spec/support/uploads/monk.jpg"
    fill_in "Video URL", with: "www.example.com/myvideo.mp4"
    
    click_button "Add Video"
    
    sign_out_user
    sign_in_user
    
    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='www.example.com/myvideo.mp4']")
   
  end
end