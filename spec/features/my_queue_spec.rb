require 'spec_helper'

feature 'my queue' do
  let(:user) { Fabricate(:user, password: 'password', password_confirmation: 'password') }
  let(:video) { Fabricate(:video) }

  background do
    video
    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario "user adds video to queue" do
    find(:xpath, ".//a[@href='/videos/#{video.id}']" ).click
    expect(page).to have_content video.title
    expect(page).to have_content 'Watch Now'
    click_link '+ My Queue'
    expect(page).to have_content 'List Order'
    expect(page).to have_content video.title
    click_link video.title
    expect(page).to have_content 'Watch Now'
    expect(page).to_not have_content '+ My Queue'
  end
end