require 'spec_helper'

feature "reset_password" do
  let!(:alice) {Fabricate(:user, password: 'old_password')}

  scenario "work-flow" do
    visit sign_in_path
    click_on("Forgot Password")

    fill_in 'Email Address', with: alice.email
    click_on 'Send Email'

    open_email(alice.email)
    current_email.click_link('Reset my password')

    alice.password = "new_password"

    fill_in "New Password", with: alice.password
    click_on('Reset Password')

    visit sign_in_path
    sign_in(alice)

    page.should have_content alice.full_name
  end
end