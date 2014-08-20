require 'spec_helper'

feature "adding new videos" do
  scenario "admin adds a video" do
    joe = Fabricate(:user, admin: true)
    comedy = Fabricate(:category, name: "Comedy")
    sign_in(joe)

    add_a_new_video
    
    sign_out
    sign_in

    view_the_new_video
  end

  def add_a_new_video
    visit new_admin_video_path
    fill_in "Title", with: "Monk"
    select "Comedy", from: "Category"
    fill_in "Description", with: "A funny detective show."
    attach_file "Large cover", "spec/support/uploads/monk_large.jpg"
    attach_file "Small cover", "spec/support/uploads/monk.jpg"
    fill_in "Video URL", with: "http://www.example.com/monk.mp4"
    click_button "Add Video"
  end

  def view_the_new_video
    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='http://www.example.com/monk.mp4']")
  end
end