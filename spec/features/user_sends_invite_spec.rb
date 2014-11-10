require 'spec_helper'

feature 'User sends invite' do
  
  background do
    # will clear the message queue
    clear_emails
  end
  
  scenario "to a non-registered user" do
    darren = Fabricate(:user)
    
    sign_in(darren)
    visit invite_path
    fill_in "Friend's Name", with: "Alice Smith"
    fill_in "Friend's Email Address", with: "alice@example.com"
    fill_in "Invitation Message", with: "You are crazy if you don't join this site!"
    click_button "Send Invitation"
    
    expect(page).to have_content("Your invitation has been sent")
    
    clear_emails
  end
  
end