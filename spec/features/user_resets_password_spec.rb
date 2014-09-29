require 'spec_helper'


feature 'user forgot password' do

   background do
    # will clear the message queue
    clear_emails
  end

  scenario 'user enters a valid email address' do
    joe = Fabricate(:user, password: 'old_password')
    visit root_path
    click_link('Sign In')
    click_link('Forgot Password?')
    fill_in "email", with: joe.email
    click_button "Send Email"
    expect(page).to have_content 'We have sent an email with instruction'

    open_email('rick.heller@yahoo.com')
    current_email.click_link 'Reset Your Password'

    expect(page).to have_content 'Reset Your Password'
    fill_in "password", with: 'gonzo'
    click_button "Reset Password"
    expect(page).to have_content 'Password has been reset'
    fill_in "email", with: joe.email
    fill_in "password", with: 'gonzo'

    click_button "Sign In"
    expect(page).to have_content "Welcome, " + joe.full_name
    
    clear_email
  end


end
