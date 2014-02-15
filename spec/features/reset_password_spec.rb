require "spec_helper"

feature "reset password" do

  scenario "user successfully resets the password" do
    alice = Fabricate(:user, password: "old_password")
    follow_links_to_sign_in
    click_link "Forgot your password?"
    fill_in "email", with: alice.email
    click_button "Send Email"

    open_email(alice.email)
    expect(current_email).to have_content "Please reset your password"
    current_email.click_link "Reset my password"
    expect(page).to have_content "Reset Your Password"

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    expect(page).to have_content "Sign in"
    
    fill_in "email", with: alice.email
    fill_in "password", with: "new_password"
    click_button "Sign in"
    expect(page).to have_content "Welcome, #{alice.full_name}"
  end

end