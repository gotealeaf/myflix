require 'spec_helper'

feature 'User signs in as a guest', {js: true, vcr: true} do
  scenario 'User signs in and invites another user to join MyFLiX', {js: true, vcr: true} do
    comedies = Fabricate(:category, name: 'Comedies')
    futurama = Fabricate(:video, title: 'Futurama', category: comedies, description: "funny show")
    bob = Fabricate(:user)
    user_signs_in(bob)

    clear_emails
    invite_a_friend
    friend_accepts_invitation

    friend_should_follow(bob)
    inviter_should_follow_friend(bob)
    clear_emails
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "invitation[guest_name]", with: "Elena Smith"
    fill_in "invitation[guest_email]", with: "elena@example.com"
    fill_in "invitation[message]", with: "Please join"
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email('elena@example.com')
    current_email.click_link 'register'
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Elena Smith"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
    click_on('Sign Up')
    expect(page).to have_text("Thank you for signing up")
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.full_name
    sign_out
  end

  def inviter_should_follow_friend(inviter)
    user_signs_in(inviter)
    click_link "People"
    expect(page).to have_content "Elena Smith"
  end
end
