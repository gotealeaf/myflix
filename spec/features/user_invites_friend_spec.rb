require 'spec_helper'
require 'faker'

feature 'User invites friend' do
  scenario 'User successfully invites friend and invitation is accepted', { js: true, vcr: true } do
    mark = Fabricate(:user)
    sign_in(mark)

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in
    friend_should_follow(mark)
    inviter_should_follow_friend(mark)

    clear_email
  end

    def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "John Doe"
    fill_in "Friend's Email Address", with: "john@example.com"
    fill_in "Message", with: "Would you like to join MyFlix?"
    click_button "Send Invitation"
    sign_out
    end

    def friend_accepts_invitation
      open_email "john@example.com"
      current_email.click_link "Accept this invitation"
      fill_in "Password", with: "password"
      fill_in "Full Name", with: "John Doe"
      click_button "Sign in"
      fill_in "Credit Card Number", with: "4242424242424242"
      fill_in "Security Code", with: "123"
      select "7 - July", from: "date_month"
      select "2015", from: "date_year"
      click_button "Sign Up"
    end

    def friend_signs_in

      fill_in "Email Address", with: "john@example.com"
      fill_in "Password", with: "password"
      click_button "Sign in"
    end

    def friend_should_follow(user)
      click_link "People"
      expect(page).to have_content user.full_name
      sign_out
    end

    def inviter_should_follow_friend(inviter)
      sign_in(inviter)
      click_link "People"
      expect(page).to have_content "John Doe"
    end  
end