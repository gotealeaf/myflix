require 'spec_helper'

feature "User invites a friend" do
  scenario "user sends invitation email to friend, who follows link and registers" do
    alice = Fabricate(:user)
    bob = Fabricate.build(:user)
    sign_in_user(alice)
    send_invite(bob)
    sign_out_user(alice)
    open_email(bob.email)
    click_registration_link(bob, current_email)
    register(bob)
    sign_in_user(bob)
  end
end

def send_invite(user)
  click_link("Invite Friend")
  expect(page).to have_content("Invite a friend to join MyFlix!")
  fill_in "Friend's Name", with: user.full_name
  fill_in "Friend's Email Address", with: user.email
  click_button "Send Invitation"
  expect(page).to have_content("Your invitation has been emailed to #{user.full_name}")
end

def click_registration_link(user, current_email)
  expect(current_email).to have_content "Click here to join!"
  current_email.click_link "Click here to join!" 
  expect(page).to have_content("Register")
end

def register(user)
  expect(find_field("Full Name").value).to have_content(user.full_name)
  expect(find_field("Email Address").value).to have_content(user.email)
  fill_in "Password", with: "password"
  click_button "Register"
  expect(page).to have_content "You registered! Welcome, #{user.full_name}!"
end