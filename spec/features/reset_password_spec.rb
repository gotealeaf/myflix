require 'spec_helper'

feature 'Reset Password' do
  let(:current_user) { Fabricate(:user) }

  scenario 'forgot password content' do
    visit signin_path
    click_link 'forgot password?'
    expect(page).to have_content 'Forgot Password?'
    fill_in 'Email Address', with: current_user.email
    click_button 'Send Email'
    expect(page).to have_content'reset your password'
  end

  background do
    clear_emails
    visit forgot_password_path
    fill_in 'Email Address', with: current_user.email
    click_button 'Send Email'
    open_email("#{current_user.email}")
  end

  scenario 'following a link' do
    current_email.click_link 'here'
    expect(page).to have_content 'Reset Your Password'
  end

  scenario 'testing for content' do
    expect(current_email).to have_content 'reset password'
    expect(current_email).to have_content "Hi #{current_user.full_name}"
  end

  scenario 'reset password' do

    current_email.click_link 'here'

    find('#password').set('00000000')
    find('#password_confimation').set('00000000')

    click_button 'Reset Password'
    expect(page).to have_content 'Password reset'

    fill_in "Email", with: current_user.email
    fill_in "Password", with: '00000000'
    click_button "Sign In"

    expect(page).to have_content current_user.full_name
  end
end
