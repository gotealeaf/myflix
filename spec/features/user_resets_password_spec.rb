require 'spec_helper'

feature "User resets password" do
  scenario "user successfully resets password" do
    desmond = Fabricate(:user, password: "old_password")
    visit login_path
    click_link "Forgot Password?"

    fill_in "Email Address", with: desmond.email
    click_button "Send Email"

    open_email(desmond.email)
    current_email.click_link "Reset My Password"

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email Address", with: desmond.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"

    expect(page).to have_content "Welcome, #{desmond.fullname}"

    clear_email
  end
end
