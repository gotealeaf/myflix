require 'spec_helper'

feature 'user sign in' do
  let(:user) { Fabricate(:user, password: 'password', password_confirmation: 'password') }
  
  background do
    user
  end

  scenario "with existing user" do
    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content 'Access granted!'
    expect(current_path).to eq home_path 
  end

  scenario "with incorrect email" do
    visit sign_in_path
    fill_in 'Email', with: 'sdkjf@sdfsd.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content 'Your email or password do not match.'
    expect(current_path).to eq sign_in_path
  end

  scenario "with incorrect password" do
    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Sign in'
    
    expect(page).to have_content 'Your email or password do not match.'
    expect(current_path).to eq sign_in_path
  end
end