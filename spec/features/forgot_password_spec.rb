require 'rails_helper'

feature "User forgot password" do
  scenario 'user resets password succesfully' do
    user = Fabricate(:user, email: 'user@example.com')
    visit sign_in_path
    click_on 'Forgot Password'
    find("input[id='email']").set(user.email)
    click_button('Send Email')
    expect(page).to have_content('instruction to reset your password.')

    open_email('user@example.com')
    current_email.click_link 'reset password'
    expect(page).to have_content('New password')

    fill_in 'password', with: 'new_password'
    fill_in 'password_confirmation', with: 'new_password'
    click_button('Reset Password')
    expect(page).to have_content('Sign in')

    fill_in 'email', with: user.email
    fill_in 'password', with: 'new_password'
    click_button 'Sign in'
    expect(page).to have_content("Welcome #{ user.username }")
  end
end
