require 'rails_helper'

feature 'User signs in' do
  
  background do
    Fabricate(:user, email: 'batman@gotham.net', password: 'bruce', password_confirmation: 'bruce')
  end
  
  scenario 'with existing login and password' do
    visit root_path
    click_link('Sign In')
    fill_in('Email', with: 'batman@gotham.net')
    fill_in('Password', with: 'bruce')
    click_on('Sign In')
    expect(page).to have_content("Signed in successfully")
  end
  
  scenario 'with incorrect password' do
    visit root_path
    click_link('Sign In')
    fill_in('Email', with: 'batman@gotham.net')
    fill_in('Password', with: 'test')
    click_on('Sign In')
    expect(page).to have_content("Incorrect email or password")
  end
  
end