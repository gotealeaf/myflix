require 'spec_helper'

feature 'Admin adds new video' do
  scenario 'Admin successfully adds a new video' do
    admin = Fabricate(:admin)
    kungfu = Fabricate(:category, name: "Action")
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: "Kung Fu"
    select "Action", from: "Category"
    fill_in "Description", with: "Panda"
    attach_file "Large cover", "spec/support/uploads/titanic_large.jpg"
    attach_file "Small cover", "spec/support/uploads/titanic_small.jpg"
    fill_in "Video URL", with: "http://www.baidu.com"
    click_button "Add Video"

    sign_out
    sign_in

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/titanic_large.jpg']")
    expect(page).to have_selector("a[href='http://www.baidu.com']")
  end
end
