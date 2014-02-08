require 'spec_helper'

feature 'invite_friends' do
  scenario 'invite a friend whow signs up' do
    alice = Fabricate(:user, full_name: "Alice Wonderland")
    sign_in(alice)

    invite_a_friend
    sign_out

    respond_to_invite_email
    sign_up_with_invitation
    receive_welcome_email
    check_follow_status
  end
end

def invite_a_friend
    click_link "Invite"
    expect(page).to have_css 'h1', text: "Invite a friend to join MyFlix!"
    fill_in "Friend's Name", with: "Bill"
    fill_in "Friend's Email", with: "Bill@example.nosend"
    fill_in "Message", with: "Join this Bill."
    click_on "Send Invitation"
    expect(page).to have_content "You successfully invited Bill."
end

def respond_to_invite_email
  open_email("Bill@example.nosend")
  expect(current_email.body).to have_content "Join this Bill."
  current_email.click_link "Accept this invitation"
  expect(page).to have_css 'h1', text: "Register"
  clear_email
end

def sign_up_with_invitation
  fill_in "Password", with: "test"
  fill_in "Full Name", with: "Bill Hill"
  click_on "sign_up"
  expect(page).to have_content "Bill Hill"
end

def receive_welcome_email
  open_email("Bill@example.nosend")
  expect(current_email.body).to have_content "Welcome to Myflix."
end

def check_follow_status
  click_link "People"
  expect(page).to have_content "Alice Wonderland"
  expect(page).to have_content "1" 
end