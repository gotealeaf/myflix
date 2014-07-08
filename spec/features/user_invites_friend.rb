require "rails_helper"

feature "User invites friend" do
  scenario "User successfully invites a friend and invitation is accepted" do
    alice = Fabricate(:user)
    sign_in(alice)

    invite_a_friend
    friend_accepts_invitation

    friend_should_follow(alice)
    inviter_should_follow_friend(alice)

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "invitation_recipient_name", with: "John Doe"
    fill_in "invitation_recipient_email", with: "john@example.com"
    fill_in "invitation_message", with: "Hey John, sign up for this site!"
    click_button "Send Invite"
    sign_out
  end

  def friend_accepts_invitation
    open_email "john@example.com"
    current_email.click_link "Accept This Invitation"

    fill_in "user_password", with: "password"
    fill_in "user_name", with: "John Doe"
    click_button "Sign Up"
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content(user.name)
    sign_out
  end

  def inviter_should_follow_friend(inviter)
    sign_in(inviter)
    click_link "People"
    expect(page).to have_content("John Doe")
  end
end