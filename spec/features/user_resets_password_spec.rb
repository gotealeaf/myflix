require 'spec_helper'

feature "user resets password" do
  scenario "current user resets password, gets email, and logs in with new password" do
    karen = Fabricate(:user, password: "old_password")
    visit sign_in_path
    clear_emails

    reset_password(karen)
    set_new_password("new_password")

    fill_in "Email Address", with: karen.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    page.should have_content(karen.full_name)
    clear_emails
  end

  def reset_password(user)
    click_link "Forgot Password?"
    fill_in "Email Address", with: user.email
    click_button "Send Email"
    open_email(user.email)
    current_email.click_link 'Reset My Password'
  end

  def set_new_password(password)
    fill_in "New Password", with: password
    click_button "Reset Password"
  end

end