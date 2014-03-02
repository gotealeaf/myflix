require 'spec_helper'

feature 'User invites friend' do
  scenario 'User successfully invites friend and invitation is accepted' do
    sam = Fabricate(:user)
    sign_in(sam)

    invite_a_friend
    friend_accepts_invitation 
    
    friend_should_follow(sam) 

    sign_in(sam)
    click_link "People"
    expect(page).to have_content "Vivian"

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Vivian"
    fill_in "Friend's Email", with: "vivian@example.com"
    fill_in "Message", with: "Hello please join this site."
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email "vivian@example.com"
    current_email.click_link "Jion MyFlix!"

    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Vivian"
    click_button "Sign Up"
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.full_name
    sign_out
  end
end
