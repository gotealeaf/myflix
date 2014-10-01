require 'spec_helper'

feature 'User invites friend' do 
  scenario 'User successfully invites friend and invitation is accepted', { js: true, vcr: true } do
    karen = Fabricate(:user) 
    sign_in(karen)

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in 

    friend_should_follow(karen)
    inviter_should_follow_friend(karen)

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Phil Doe"
    fill_in "Friend's Email", with: "phil@email.com"
    fill_in "Message", with: "Please join this cool site"
    click_button "Send Invitation"
    visit sign_out_path
  end

  def friend_accepts_invitation
    open_email("phil@email.com")
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Phil Doe"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "#{Time.now.year + 2}", from: "date_year"
    click_button "Sign Up"
  end

  def friend_signs_in
    fill_in "Email Address", with: "john@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
  end

  def friend_should_follow(a_user)
    click_link "People"
    page.should have_content a_user.full_name
    visit sign_out_path
  end

  def inviter_should_follow_friend(inviter)
    sign_in(inviter)
    click_link "People"
    page.should have_content "John Doe"
  end
end