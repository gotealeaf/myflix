require 'spec_helper'

feature 'reset password' do
  let(:johnny) { Fabricate(:user) }

  background do
    clear_emails
  end

  scenario 'user resets password' do
    visit sign_in_path
    click_link 'Forgot Password?'
    expect(page).to have_content 'Email Address'

    fill_in 'Email Address', with: johnny.email
    click_button 'Send Email'
    expect(page).to have_content 'We have send an email'

    open_email(johnny.email)
    current_email.should have_content johnny.password_token

    current_email.click_link 'Reset Password'
    expect(page).to have_content 'New password'

    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    click_button 'Reset Password'
    expect(page).to have_content 'password has been reset'

    sign_in(johnny)
    expect(page).to have_content 'Access granted!'
  end

  scenario 'user fills in incorrect email address' do
    visit forgot_password_path
    fill_in 'Email Address', with: 'invalid@example.com'
    click_button 'Send Email'
    expect(page).to have_content 'not recognized'
  end

  scenario 'user\'s passwords do no match' do
    visit forgot_password_path

    fill_in 'Email Address', with: johnny.email
    click_button 'Send Email'

    open_email(johnny.email)

    current_email.click_link 'Reset Password'

    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'nomatch'
    click_button 'Reset Password'
    expect(page).to have_content 'do not match'
  end

  scenario 'invalid password token is used to visit reset password page' do
    visit('/password_resets/badtoken')
    expect(page).to have_content 'link is expired'
  end
end