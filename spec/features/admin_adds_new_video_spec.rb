require 'spec_helper'

feature 'Admin adds new video' do
  scenario 'Admin succesfully adds a new video' do
    admin = Fabricate :admin
    thriller = Fabricate :category, name: "Thriller"
    sign_in admin
    visit new_admin_video_path

    fill_in "Title", with: "The Wire"
    select "Thriller", from: "Category"
    fill_in "Description", with: "Really good show."
    attach_file "Large cover", "spec/support/uploads/the_wire.jpg"
    attach_file "Small cover", "spec/support/uploads/The_Wire_Bajo_escucha_Serie_de_TV-612640292-large.jpg"
    fill_in "Video URL", with: "http://youtu.be/zmIvu1yg3bU"
    click_button "Add Video"

    sign_out
    sign_in

    visit video_path Video.first

    expect(page).to have_selector("a[href='http://youtu.be/zmIvu1yg3bU']")
  end 
end