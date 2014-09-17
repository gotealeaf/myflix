require 'spec_helper'

feature "user resets password" do
  scenario "current user resets password, gets email, and logs in with new password" do
    clear_emails
    karen = Fabricate(:user)
    visit sign_in_path
    page.should have_content("Sign in")
    click_link "Forgot Password?"
    fill_in "Email Address", with: karen.email
    click_button "Send Email"
    page.should have_content("We have sent an email with instructions to reset your password.")
    open_email(karen.email)
    current_email.click_link 'Reset My Password'

    set_new_password("new_password")

    fill_in "Email Address", with: karen.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    page.should have_content(karen.full_name)

  end

  def set_new_password(password)
    fill_in "New Password", with: password
    click_button "Reset Password"
  end
end