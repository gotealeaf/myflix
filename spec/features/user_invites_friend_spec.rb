require 'spec_helper'


feature 'user invites friend' do

   background do
    # will clear the message queue
    clear_emails
  end

  scenario 'user enters a valid email address' do
    joe = Fabricate(:user)
    sign_in(joe)
    click_link "Welcome, " + joe.full_name
    click_link('Invite A Friend')
    expect(page).to have_content "Friend's Name"

    fill_in "Friend's Name", with: "Jamie Smil"
    fill_in "Friend's Email Address", with: "seeingtheroses@gmail.com"
    fill_in "Invitation Message", with: "Hi dere"
    click_button "Send Invitation"
    sign_out

    open_email('rick.heller@yahoo.com')
    current_email.click_link 'Register'

    expect(page).to have_content 'Password'
    fill_in "Password", with: 'gonzo'
    fill_in "Full Name", with: "Jamie Smil"
    click_button "Sign Up"
    expect(page).to have_content 'Sign In'
    
    fill_in "email", with: 'seeingtheroses@gmail.com'
    fill_in "password", with: 'gonzo'
    click_button "Sign In"
    expect(page).to have_content "Welcome, " + "Jamie Smil"

    click_link('People')
    expect(page).to have_content joe.full_name
    sign_out

    click_link('Sign In')

    fill_in "email", with: joe.email
    fill_in "password", with: joe.password
    click_button "Sign In"
    expect(page).to have_content "Welcome, " + joe.full_name

    click_link('People')
    expect(page).to have_content "Jamie Smil"
    
    clear_email
  end


end
