require 'spec_helper'

feature 'User resets password' do
  scenario 'user successfully resets password' do
    amanda = Fabricate(:user, password:'old_password')
    visit sign_in_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: amanda.email
    click_button "Send Email"

    open_email(amanda.email)
    current_email.click_link("Reset My Password")

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email Address", with: amanda.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    expect(page).to have_content("Welcome, #{amanda.full_name}")
  end

end