require "spec_helper"

feature "reset email" do
  scenario "user resets their password" do
    michelle = Fabricate(:user, password: "password")

    visit login_path
    click_link "Forgot Password"
    fill_in "Email Address", with: michelle.email
    click_button "Send Email"

    open_email(michelle.email)
    current_email.click_link "Reset Password"

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email Address", with: michelle.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    expect(page).to have_content "Welcome, #{michelle.fullname}"
  end
end