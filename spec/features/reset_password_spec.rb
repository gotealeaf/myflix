require 'spec_helper'

feature 'reset password' do
  let(:johnny) { Fabricate(:user) }

  background do
    clear_emails
  end

  scenario 'user resets password' do
    request_password_reset_email
    open_email_and_click_link
    fill_in_password_and_submit
    sign_in_with_new_password

    expect(page).to have_content 'Access granted!'
  end

  scenario 'user fills in incorrect email address' do
    visit forgot_password_path
    fill_in 'Email Address', with: 'invalid@example.com'
    click_button 'Send Email'
    expect(page).to have_content 'not recognized'
  end

  scenario 'user\'s passwords do no match' do
    request_password_reset_email
    open_email_and_click_link

    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'nomatch'
    click_button 'Reset Password'
    expect(page).to have_content 'do not match'
  end

  scenario 'invalid password token is used to visit reset password page' do
    visit('/password_resets/badtoken')
    expect(page).to have_content 'link is expired'
  end

  private

  def request_password_reset_email
    visit sign_in_path
    click_link 'Forgot Password?'
    expect(page).to have_content 'Email Address'

    fill_in 'Email Address', with: johnny.email
    click_button 'Send Email'
  end

  def open_email_and_click_link
    open_email(johnny.email)
    current_email.should have_content johnny.password_token

    current_email.click_link 'Reset Password'
  end

  def fill_in_password_and_submit
    fill_in 'password', with: 'new_password'
    fill_in 'password_confirmation', with: 'new_password'
    click_button 'Reset Password'
  end

  def sign_in_with_new_password
    fill_in 'Email', with: johnny.email
    fill_in 'Password', with: 'new_password'
    click_button 'Sign in'
  end
end