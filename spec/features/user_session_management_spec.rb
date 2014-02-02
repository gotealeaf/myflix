require 'spec_helper'

feature 'User session management' do
  scenario 'User signs in' do
    adam = Fabricate(:user)
    sign_in(adam)
    expect(page).to have_content(adam.full_name)
  end

  scenario 'User signs out' do
    adam = Fabricate(:user)
    sign_in(adam)
    visit root_path
    click_on "Welcome, #{adam.full_name}"
    click_on 'Sign Out'
    expect(page).to have_content 'successfully logged out'
  end
end
