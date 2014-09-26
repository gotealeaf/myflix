require 'spec_helper'


feature 'user invites friend' do

   background do
    # will clear the message queue
    clear_emails
  end

  scenario 'user enters a valid email address' do
    joe = Fabricate(:user)

    sign_in(joe)
    invite_a_friend(joe)
    sign_out

    friend_accepts_invite
    friend_signs_in    
    click_link('People')
    expect(page).to have_content joe.full_name
    sign_out

    sign_in(joe)
    click_link('People')
    expect(page).to have_content "Jamie Smil"
    
    clear_email
  end
#########################################
  def invite_a_friend inviter
    click_link "Welcome, " + inviter.full_name
    click_link('Invite A Friend')
    expect(page).to have_content "Friend's Name"

    fill_in "Friend's Name", with: "Jamie Smil"
    fill_in "Friend's Email Address", with: "seeingtheroses@gmail.com"
    fill_in "Invitation Message", with: "Hi dere"
    click_button "Send Invitation"
  end

  def friend_accepts_invite
    open_email('rick.heller@yahoo.com')
    current_email.click_link 'Register'
    expect(page).to have_content 'Password'
    fill_in "Password", with: 'gonzo'
    fill_in "Full Name", with: "Jamie Smil"
    click_button "Sign Up"
    expect(page).to have_content 'Sign In'
  end

  def friend_signs_in
    fill_in "email", with: 'seeingtheroses@gmail.com'
    fill_in "password", with: 'gonzo'
    click_button "Sign In"
    expect(page).to have_content "Welcome, " + "Jamie Smil"
  end

end
