require 'spec_helper'

feature 'User session management' do
  background do
    User.create(email: 'test@user.com', password: 'password', full_name: 'Test User')
  end

  scenario 'User signs in' do
    visit root_path
    click_on 'Sign In'
    fill_in 'Email Address', with: 'test@user.com'
    fill_in 'Password', with: 'password'
    click_on 'Sign in'
    expect(page).to have_content('Test User')
  end

  scenario 'User signs out' do
    page.set_rack_session(user_id: User.find_by(email: 'test@user.com').id)
    visit root_path
    click_on 'Welcome, Test User'
    click_on 'Sign Out'
    expect(page).to have_content 'successfully logged out'
  end
end
