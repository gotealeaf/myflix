require 'spec_helper'

feature "user invites a friend" do
  scenario "a user invites a friend who is not registered" do
    billy = sign_in

    invite_a_friend
    friend_accepts_invitation

    friend_should_follow_inviter(billy)
    inviter_should_follow_friend(billy)

    clear_email
  end

  private

  def invite_a_friend
    click_link 'People'
    click_link 'Invite a friend'
    fill_in "Friend's Name", with: 'John Doe'
    fill_in "Friend's Email Address", with: 'john@example.com'
    click_button 'Send Invitation'
    sign_out
  end

  def friend_accepts_invitation
    open_email_and_click_link('john@example.com', 'Register Now!')
    fill_in 'Password', with: 'secret_password'
    fill_in 'Confirm Password', with: 'secret_password'
    click_button 'Sign Up'
    open_email_and_click_link('john@example.com', 'Click here to log in.')
  end

  def friend_should_follow_inviter(inviter)
    sign_in(User.find_by_email('john@example.com'), 'secret_password')
    click_link 'People'
    expect(page).to have_content inviter.full_name
    sign_out
  end

  def inviter_should_follow_friend(inviter)
    sign_in(inviter)
    click_link 'People'
    expect(page).to have_content 'John Doe'
  end
end