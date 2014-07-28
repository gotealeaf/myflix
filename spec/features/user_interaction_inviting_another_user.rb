require 'spec_helper'
require 'capybara/email/rspec'

feature "User interaction with invitations" do
  scenario "user invites another user to join the app", { js: true, vcr: true } do
    ana = Fabricate :user, email: "paq5@paq.com"
    ana.update_column(:token, "123456")

    sign_in ana

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in

    #friend_should_follow ana
    #inviter_should_follow_friend ana

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Paquito"
    fill_in "Friend's Email Address", with: "paq10@paq.com"
    fill_in "Invitation Message", with: "Brasismo extremisimo."
    click_link "dlabel"
    click_button "Send Invitation"
    sign_out      
  end

  def friend_accepts_invitation
    open_email('paq10@paq.com')
    current_email.click_link "Join Myflix!"
    page.should have_content "Register"
    fill_in "user_email", with: "paq10@paq.com"
    fill_in "user_password", with: "12345678"
    fill_in "user_password_confirmation", with: "12345678"
    fill_in "user_full_name", with: "Paquito Testeando"    
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
    click_button "Sign Up"   
    #open_email('paq10@paq.com')
    #current_email.should have_content "Welcome to Myflix"      
  end

  def friend_signs_in
    visit sign_in_path
    fill_in "Email", with: "paq10@paq.com"
    fill_in "Password", with: "12345678"    
    click_button "Sign in"  
    page.should have_content "Paquito Testeando"
  end

  def friend_should_follow inviter
    visit people_path
    page.should have_content "#{inviter.full_name}"
    sign_out
  end

  def inviter_should_follow_friend inviter
    sign_in inviter
    visit people_path
    page.should have_content "Paquito Testeando"    
    page.should_not have_content "#{inviter.full_name}"    
  end
end