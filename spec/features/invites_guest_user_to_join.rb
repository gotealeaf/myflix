require 'spec_helper'

feature 'User signs in as a guest' do
  scenario 'User signs in and invites another user to join MyFLiX' do
    comedies = Fabricate(:category, name: 'Comedies')
    futurama = Fabricate(:video, title: 'Futurama', category: comedies, description: "funny show")
    bob = Fabricate(:user)
    user_signs_in(bob)
    clear_emails
    visit new_invitation_path
    fill_in "invitation[guest_name]", with: "Alice Smith"
    fill_in "invitation[guest_email]", with: "alice@example.com"
    fill_in "invitation[message]", with: "Please join"
    click_button 'Send Invitation'
    open_email('alice@example.com')
    current_email.click_link 'register'
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Alice Smith"
    click_on('Create')
    expect(page).to have_text("Thank you for signing up")
    find("a[href='/videos/#{futurama.id}']").click
    expect(page).to have_content(futurama.title)
  end
end
