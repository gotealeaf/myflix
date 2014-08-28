require 'rails_helper'

feature 'User invites a friend to MyFlix', :vcr do
  scenario 'a friend registers after an invitation from a current user', { js: true, vcr: true } do
    inviter = Fabricate(:user)
    visit sign_in_path
    user_signs_in(inviter)
    visit invite_path
    fill_in 'invite__friend_name', with: 'Nelle'
    fill_in 'invite__friend_email', with: 'nelle@example.com'
    click_on 'Send Invitation'
    expect(page).to have_content("Nelle has been invited to join NetFlix. Thanks!!")
    open_email('nelle@example.com')
    current_email.click_link 'Join'
    expect(page).to have_content('Register')
    page.has_field?('Email', with: 'nelle@example.com')

    fill_in 'user_username', with: 'unicorn'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    fill_in 'card_number', with: '4242424242424242'
    fill_in 'card_cvc', with: '123'
    select('2016', from: 'card-expiry-year')
    click_on 'Sign Up'
    expect(page).to have_content("Welcome, Nelle")

    click_on 'People'
    expect(page).to have_content(inviter.full_name)
  end
end
