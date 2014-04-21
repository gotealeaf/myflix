require 'pry'
require 'spec_helper'

feature 'request and then reset password as user' do

  scenario 'reset password for existing user', :js => true do
    adam = Fabricate(:user)

    visit login_path
    click_link("Forgotten Password?")

    expect(page).to have_content("We will send you an email with a link that you can use to reset your password.")

    fill_in 'Email', with: adam.email

    click_button "Submit"


    open_email(adam.email)

    current_email.click_link 'Reset Password'
    expect(page).to have_content("Enter your new password")

    new_password = "adam_new_password"
    fill_in "Password", with: new_password
    click_button "Update Password"

    expect(page).to have_content("Your password has been updated.")

    fill_in "Email", with: adam.email
    fill_in "Password", with: new_password
    click_button "Submit"

    expect(page).to have_content("You are now logged in.")

  end
end
