require 'spec_helper'

feature 'Admin adds new video' do
  scenario 'Admin successfuly adds a new video' do
    admin = Fabricate(:admin)
    category = Fabricate(:category)
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: 'Video1'
    select category.name, from: 'Category'
    fill_in "Description", with: "Video1 Description"
    attach_file "Large cover", "spec/support/uploads/monk_large.jpg"
    attach_file "Small cover", "spec/support/uploads/monk.jpg"
    fill_in "Video URL", with: "http://diikjwpmj92eg.cloudfront.net/office_hours/webdev_from_the_ground_up_part1.m4v"
    click_button "Add Video"

    sign_out
    sign_in

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='http://diikjwpmj92eg.cloudfront.net/office_hours/webdev_from_the_ground_up_part1.m4v']")
  end
end
