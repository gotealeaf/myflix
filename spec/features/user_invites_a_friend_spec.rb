require 'spec_helper'

feature "user invites a friend" do
  scenario "friend joins and they follow each other", { js: true, vcr: true } do 
    jane = Fabricate(:user)
    sign_in_user(jane)  
    
    invite_friend
    friend_accepts_invite
    friend_successfully_registers
    confirm_relationship_with(jane.full_name)
    sign_out_user #Joe Bloggs
    
    sign_in_user(jane)
    confirm_relationship_with("Joe Bloggs")
    
    clear_email
    
  end
  
  def invite_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Joe Bloggs"
    fill_in "Friend's Email Address", with: "joe@example.com"
    fill_in "Message", with: "Join!" 
    click_button "Send Invitation"
  end
  
  def friend_accepts_invite
    open_email("joe@example.com")
    current_email.click_link("Accept the Invitation")
  end
  
  def friend_successfully_registers
    expect(page).to have_content("Register")
    fill_in "Full Name", with: "Joe Bloggs"
    fill_in "Password", with: "password"
    fill_in "credit-card-number", with: "4242424242424242"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2017", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Welcome, Joe Bloggs")
  end
  
  def confirm_relationship_with(name)
    visit people_path
    expect(page).to have_content(name)
  end
end