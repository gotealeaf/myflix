require 'spec_helper'

feature "User invites a friend" do
  scenario "user invites friend, who accepts invitation and registers", js: true, driver: :selenium do
    alice = Fabricate(:user)
    bob = Fabricate.build(:user)

    sign_in_user(alice)
    send_invite(bob)
    sign_out_user(alice)

    open_email(bob.email)
    click_registration_link(current_email)
    register_with_invitation(bob)
    
    sign_in_user(bob)
    confirm_user_registered(bob)
    confirm_user_following(alice)
    sign_out_user(bob)
    
    sign_in_user(alice)
    confirm_user_following(bob)
    clear_emails
  end
end

def send_invite(user)
  visit new_invitation_path
  expect(page).to have_content("Invite a friend to join MyFlix!")
  fill_in "Friend's Name", with: user.full_name
  fill_in "Friend's Email Address", with: user.email
  click_button "Send Invitation"
  expect(page).to have_content("Your invitation has been emailed to #{Invitation.first.recipient_name}")
end

def click_registration_link(current_email)
  expect(current_email).to have_content "Click here to join!"
  current_email.click_link "Click here to join!" 
  expect(page).to have_content("Register")
end

def register_with_invitation(user)
  expect(find_field("Full Name").value).to have_content(user.full_name)
  expect(find_field("Email Address").value).to have_content(user.email)
  fill_in "Password", with: user.password
  fill_in "Credit Card Number", with: "4242424242424242"
  fill_in "Security Code", with: "123"
  find("#date_month").select("6 - June")
  find("#date_year").select("2017")
  VCR.use_cassette("valid_card_feature_spec") do
    click_button "Register"
  end
  expect(page).to have_content "You registered! Welcome, #{user.full_name}!"
end

def confirm_user_following(another_user)
  click_link "People"
  expect(page).to have_content("#{another_user.full_name}")
end