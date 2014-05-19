require 'spec_helper'

feature "user resets password" do
  scenario "user successfully resets the password" do #only test this as the rest were tested before
    jane = Fabricate(:user, password: 'old_password')
    visit login_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: jane.email
    click_button "Reset Password"
    
    #then use Capybara's email gem to open the email we sent to the user
    open_email(jane.email)
    current_email.click_link("Reset Password")
    
    # link within email will take you to the reset password page
    fill_in "New Password", with: 'new_password'
    click_button "Reset Password"
    
    # reseting the password will take you to the sign in page
    fill_in "Email Address", with: jane.email
    fill_in "Password", with: 'new_password'
    click_button "Sign in"
    expect(page).to have_content("Welcome, #{jane.full_name}")
  end
end