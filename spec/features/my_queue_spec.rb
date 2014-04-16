require 'spec_helper'

feature 'my queue' do
  let(:user) { fabricate(:user, password: 'password', password_confirmation: 'password') }
  let(:video) { fabricate(:video) }

  background do
    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario "user adds video to queue" do
    # TODO: Click on the video.

    click_button '+ My Queue'
    expect(page).to have_content video.title

    # TODO: Click on video link.

    expect(page).to_not have_content "+ My Queue"
  end

  scenario "user reorders videos"
    # TODO: Add more videos to my queue.
    # TODO: Reorder videos

end