require 'spec_helper'

feature "Adding a video and watching it" do
  scenario "Admin adds video and regular user watches it" do
    reality = Fabricate(:category, name: 'Reality TV')
    bob = Fabricate(:user)
    alice = Fabricate(:admin)

    user_signs_in(alice)
    visit new_admin_video_path
    fill_in "video[title]", with: "Albanian Baywatch"
    select "Reality TV", from: "video[category_id]"
    fill_in "video[description]", with: "The best Baywatch ever!"
    attach_file "video[large_cover]", "spec/support/uploads/monk_large.jpg"
    attach_file "video[small_cover]", "spec/support/uploads/monk.jpg"
    fill_in "video[video_url]", with: "https://www.youtube.com/watch?v=W_g3Y_B6oKc"
    click_button 'Add Video'
    sign_out

    user_signs_in(bob)
    visit video_path(Video.first)
    expect(page).to have_content("Albanian Baywatch")
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='https://www.youtube.com/watch?v=W_g3Y_B6oKc']")
  end
end