require 'rails_helper'

feature "Forgot Password" do
  given(:user) { Fabricate(:user, email: 'user@example.com') }

  scenario 'user forgets password and resets it' do
    visit forgot_password_path
    find("input[id='email']").set(user.email)
    click_button('Send Email')
    expect(page).to have_content('instruction to reset your password.')
    open_email('user@example.com')
    current_email.click_link 'reset password'
    expect(page).to have_content('New password')
  end
end
