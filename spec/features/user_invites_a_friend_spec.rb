require 'spec_helper'

feature "user invites a friend" do
  scenario "friend joins and they follow each other" do 
    jane = Fabricate(:user)
    sign_in_user(jane)    
    visit new_invitation_path
    
    fill_in "Friend's Name", with: "Joe Bloggs"
    fill_in "Friend's Email Address", with: "joe@example.com"
    fill_in "Message", with: "Join!"
    
    click_button "Send Invitation"
    
    open_email("joe@example.com")
    current_email.click_link("Accept the Invitation")

    expect(page).to have_content("Register")
    fill_in "Full Name", with: "Joe Bloggs"
    fill_in "Password", with: "password"
    click_button "Register"
    
    expect(page).to have_content("Welcome, Joe Bloggs")
    
    visit people_path
    expect(page).to have_content(jane.full_name)
    
    clear_email
    
  end
end