require 'spec_helper'

feature 'user invite friend' do
  let(:current_user) { Fabricate(:user) }

  scenario 'friend accept' do
    signin(current_user)

    invite_friend
    friend_accepts_invitation

    click_link "People"
    expect(page).to have_content(current_user.full_name)
    signout

    signin(current_user)
    click_link "People"
    expect(page).to have_content(current_user.full_name)
    signout

    clear_emails
  end

  def invite_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Ben"
    fill_in "Recipient email", with: "example@example.com"
    fill_in "Invitation Message", with: "Please join this really cool site!"
    click_button 'Send Invitation'
    signout
  end

  def friend_accepts_invitation
    open_email("example@example.com")
    current_email.click_link 'here'
    fill_in "Password", with: "00000000"
    fill_in "Confirm Password", with: "00000000"
    click_button "Sign Up"
  end
end
