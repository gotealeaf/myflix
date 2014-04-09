require 'spec_helper'

feature 'User signs in with new password' do
  scenario 'User forgets password and tries to re-assign his/her password' do
    comedies = Fabricate(:category, name: 'Comedies')
    futurama = Fabricate(:video, title: 'Futurama', category: comedies, description: "funny show")
    bob = Fabricate(:user, email: 'bob@example.com')
    clear_emails
    visit email_page_path
    fill_in "email", with: "bob@example.com"
    click_button "Send Email"
    open_email('bob@example.com')
    current_email.click_link 'Click Here'
    fill_in "password", with: "new_password"
    click_button "Reset Password"
    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    find("a[href='/videos/#{futurama.id}']").click
    expect(page).to have_content(futurama.title)
  end
end
