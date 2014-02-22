require "spec_helper"

feature "add video" do

  scenario "successfully add video and verify that it can be played" do
    sign_in_admin
    Fabricate(:category, name: "biographies")
    click_link "Add Videos"
    fill_in "Title", with: "Gandhi"
    select "biographies", from: "Category"
    fill_in "Description", with: "great video"
    attach_file "Large Cover", "public/tmp/gandhi_large.jpg"
    attach_file "Small Cover", "public/tmp/gandhi.jpg"
    fill_in "Video URL", with: "https://s3.amazonaws.com/myflix-joe/Gandhi+-+Official%C2%AE+Trailer+%5BHD%5D.mp4"
    click_button "Add Video"
    sign_out
    sign_in
    expect(page).to have_selector("img[src='/uploads/gandhi.jpg']")
    click_on_video_on_home_page(Video.first)
    expect(page).to have_content("Gandhi")
    expect(page).to have_selector("img[src='/uploads/gandhi_large.jpg']")
    expect(page).to have_selector("a[href='https://s3.amazonaws.com/myflix-joe/Gandhi+-+Official%C2%AE+Trailer+%5BHD%5D.mp4']")
  end

end