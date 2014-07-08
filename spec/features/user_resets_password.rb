require "rails_helper"

feature "User resets password" do
  scenario "User successfully resets his password" do
    alice = Fabricate(:user, password: "old_password")

    visit sign_in_path
    click_link "Forgot Password"
    find(".forgot_password").fill_in "email", with: alice.email
    click_button "Send Email"

    open_email(alice.email)
    current_email.click_link "Reset My Password"

    fill_in "New Password", with: "new_password"
    click_button "Update Password"

    find(".sign_in").fill_in "email", with: alice.email
    find(".sign_in").fill_in "password", with: "new_password"
    find(".sign_in").click_button "Sign In"

    expect(page).to have_content(alice.name)

    clear_email
  end
end