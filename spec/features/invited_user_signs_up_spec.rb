require 'spec_helper'

feature "Invited Friend Signs Up" do
  given(:joe) { Fabricate(:user) }

  scenario "user sends invitation to friend who signs up" do
    signin_user(joe)
    page.should have_content "Welcome"

    visit invite_path
    page.should have_content "Invite a friend"
    user_invites_a_friend
    joe_signs_out

    friend_accepts_invitation
    page.should have_content "Register"

    friend_signs_up
    page.should have_content "Welcome"

    click_link "People"
    already_following("#{joe.name}")

    friend_signs_out
    page.should have_content "Unlimited"

    signin_user(joe)
    page.should have_content "Welcome"
    click_link "People"
    already_following("Jen")

    clear_email
  end
end

def user_invites_a_friend
  fill_in "Friend's Name",          with: "Jen"
  fill_in "Friend's Email Address", with: "jen@example.com"
  fill_in "Invitation Message",     with: "Join me!"
  click_button "Send Invitation"
  page.should have_content "Invite a friend"
end

def joe_signs_out
  click_link "Sign Out"
end

def friend_accepts_invitation
  open_email "jen@example.com"
  current_email.click_link "Join MyFLiX"
end

def registration_form_has_email_already_filled_in
  find_field("user_email").value.should eq("jen@example.com")
end

def friend_signs_up
  registration_form_has_email_already_filled_in
  fill_in "Password", with: "password"
  fill_in "Full Name", with: "Jennifer"
  click_button "Sign Up"
end

def friend_signs_out
  click_link "Sign Out"
end

def already_following(user)
  page.should have_content "#{user}"
end
