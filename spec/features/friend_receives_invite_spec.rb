require 'spec_helper'

feature 'friend receives invite' do
  
  scenario "friend signs up from invitation email link" do
    darren = Fabricate(:user)
    invitation = Fabricate(:invitation, user_id: darren.id)
    
    visit invitation_url(invitation.token)
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Alice Smith"
    click_button "Sign Up"
    
    alice = User.find_by(email: invitation.friend_email)
    
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: "password"
    click_button "Sign in"
    expect(page).to have_content("Welcome, Alice Smith")
    
    click_link("Following")
    expect(page).to have_content(darren.full_name)
    sign_out
    
    sign_in(darren)
    click_link("Following")
    expect(page).to have_content(alice.full_name)
  end
  
end