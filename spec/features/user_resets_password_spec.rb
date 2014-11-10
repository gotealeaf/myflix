require 'spec_helper'

feature 'User resets password' do
  
  background do
    # will clear the message queue
    clear_emails
  end
  
  scenario "with valid email and password" do
    darren = Fabricate(:user, password: 'old_password')
    
    visit sign_in_path
    click_link "Forgot your password?"
    fill_in "Email Address", with: darren.email
    click_button "Send Email"
    
    open_email(darren.email)
    current_email.click_link 'Reset My Password'
    
    fill_in "New Password", with: 'new_password'
    click_button "Reset Password"
    
    fill_in "Email Address", with: darren.email
    fill_in "Password", with: 'new_password'
    click_button "Sign in"
    expect(page).to have_content("Welcome, #{darren.full_name}")
    
  end
end