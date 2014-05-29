require 'capybara/email/rspec'

feature "User interaction with invitations" do
  scenario "user invites another user to join the app" do
    ana = Fabricate :user, email: "paq5@paq.com"
    ana.update_column(:token, "123456")
    sign_in

    visit new_invitation_path

    fill_in "Friend's Name", with: "Paquito"
    fill_in "Friend's Email Address", with: "paq10@paq.com"
    fill_in "Invitation Message", with: "Brasismo extremisimo."
    click_button "Send Invitation"

    open_email('paq10@paq.com')
    current_email.click_link "Join Myflix!"

    page.should have_content "Register"

    fill_in :email, with: "paq10@paq.com"
    fill_in :password, with: "123456"
    fill_in :password_confirmation, with: "123456"
    fill_in :full_name, with: "Paquito"    
    click_button "Sign Up"

    open_email('paq10@paq.com')
    current_email.include "Welcome to Myflix"
  end
end