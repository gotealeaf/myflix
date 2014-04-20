require 'spec_helper'

feature "User Resets Password" do
  given!(:joe) { Fabricate(:user, email: "joe@example.com") }

  scenario "user goes through process to reset password" do
    visit signin_path
    click_link "forgot password"

    visit forgot_password_path
    page.should have_content "reset your password."

    fill_in "Email Address", with: "joe@example.com"
    click_button "Send Email"

    open_email("joe@example.com")
    current_email.should have_content "To Reset Your Password"

    current_email.click_link "Reset Password"
    page.should have_content "Reset Your Password"

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    page.should have_content "Sign in"

    fill_in "Email Address", with: "joe@example.com"
    fill_in "Password",      with: "new_password"
    click_button "Sign in"
    page.should have_content "Welcome"

    clear_email
  end
end
