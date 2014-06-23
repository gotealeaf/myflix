require 'spec_helper'
require 'capybara/email/rspec'

feature "User interaction with invitations" do
  scenario "user invites another user to join the app" do
    ana = Fabricate :user, email: "paq5@paq.com"
    ana.update_column(:token, "123456")

    sign_in ana

    visit new_invitation_path

    fill_in "Friend's Name", with: "Paquito"
    fill_in "Friend's Email Address", with: "paq10@paq.com"
    fill_in "Invitation Message", with: "Brasismo extremisimo."
    click_button "Send Invitation"

    open_email('paq10@paq.com')
    current_email.click_link "Join Myflix!"

    page.should have_content "Register"

    fill_in "user_email", with: "paq10@paq.com"
    fill_in "user_password", with: "12345678"
    fill_in "user_password_confirmation", with: "12345678"
    fill_in "user_full_name", with: "Paquito Testeando"    
    click_button "Sign Up"

    open_email('paq10@paq.com')
    current_email.should have_content "Welcome to Myflix"

    visit people_path
    page.should have_content "Paquito Testeando"

    sign_out
    page.should_not have_content "#{ana.full_name}"

    visit sign_in_path
    fill_in "Email", with: "paq10@paq.com"
    fill_in "Password", with: "12345678"
    click_button "Sign in"  
    page.should have_content "Paquito Testeando"

    visit people_path
    page.should have_content "#{ana.full_name}"

    clear_email
  end
end