require 'spec-helper'

feature "reset_password" do
  let!(:alice) {Fabricate(:user, password: 'old_password')}

  scenario "work-flow" do
    visit sign_in_path
    click_on("Forgot Password")

    fill_in 'Email Address', with: alice.Email
    click_on 'Send Email'

    open_email(alice.email)
    current_email.click_link('Reset my password')

    fill_in "New Password", with: "new_password"
    click_on('Reset Password')

    sign_in(alice)
    page.should have_content alice.fullname
  end
end