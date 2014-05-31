require 'spec_helper'

feature "admin uploads new videos" do
  scenario "successfully uploads video and it is searchable by users" do
    set_admin
    visit new_admin_video_path
    
    fill_in "Title", with: "Police Story 3"
    select
    fill_in "Description", with: "An engaging story"
    click_button "Add Video"
    
    visit home_path
    expect(page).to have_content("Police Story 3")
    
    sign_out
    
    sign_in_user
    
    
    
  end
end