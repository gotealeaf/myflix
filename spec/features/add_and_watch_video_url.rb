require 'rails_helper'

feature 'Admin adds video' do
  scenario 'user watches video added by admin' do
    admin = Fabricate(:user, email: 'admin@example.com', admin: true)
    user = Fabricate(:user, email: 'user@example.com')
    genre = Fabricate(:genre, name: 'Sci Fi')
    user_signs_in(admin)
    expect(page).to have_content("Welcome #{ admin.username }")
    visit new_admin_video_path

    fill_in 'video_name', with: 'Avatar'
    select('Sci Fi', from: 'video_genre_id')
    fill_in 'video_description', with: 'A Sci Fi movie'
    attach_file('video_large_cover', 'app/assets/images/avatar_lrg.jpg')
    attach_file('video_small_cover', 'app/assets/images/avatar_sml.jpg')
    fill_in 'video_video_url', with: 'http://some_url.com'
    click_button('Add Video')
    user_signs_out
    expect(page).to have_content('You have signed out.')

    user_signs_in(user)
    expect(page).to have_content("Welcome #{ user.username }")
    expect(page).to have_selector("img[src='/uploads/avatar_sml.jpg']")

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/avatar_lrg.jpg']")
    expect(page).to have_selector("a[href='http://some_url.com']")
  end
end
