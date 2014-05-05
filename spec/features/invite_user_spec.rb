require 'spec_helper'

feature "user invites a friend" do
  let(:billy) { Fabricate(:user) }

  scenario "a user invites a friend who is not registered" do
    sign_in(billy)
    click_link 'People'
    click_link 'Invite by email'

    fill_in "Friend's Name", with: 'John Doe'
    fill_in "Friend's Email Address", with: 'john@example.com'
    click_button 'Send Invitation'
    click_link 'Sign Out'

    open_email('john@example.com')
    current_email.click_link 'Register Now!'

    fill_in 'Email Address', with: 'john@example.com'
    fill_in 'Password', with: 'secret_password'
    fill_in 'Confirm Password', with: 'secret_password'
    fill_in 'Full Name', with: 'John Doe'
    click_button 'Sign Up'

    open_email('john@example.com')
    current_email.click_link 'Click here to log in.'

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'secret_password'
    click_button 'Sign in'
    save_and_open_page

    click_link 'People'
    expect(page).to have_content 'billy.full_name'
  end
end