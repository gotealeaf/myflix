require 'spec_helper'

feature "reset_password_refactor" do
  let!(:alice) {Fabricate(:user, password: 'old_password')}

  scenario "work-flow" do
    visit sign_in_path
    click_on("Forgot Password")

    fill_in 'Email Address', with: alice.email
    click_on 'Send Email'

    open_email(alice.email)
    current_email.click_link('Reset my password')

    fill_in "New Password", with: "new_password"
    click_on('Reset Password')

    fill_in "Email Address", with: alice.email
    fill_in "Password", with: "new_password"
    click_on "Sign in"
    page.should have_content alice.full_name
  end
end

feature "reset_password" do
  let!(:alice) {Fabricate(:user, email: 'me@them.com')}

  scenario "user visit sign in page" do
    visit sign_in_path
    page.should have_css('#forgot_password')
  end

 scenario "user clicks forgot password button at sign in" do
    visit sign_in_path
    
     find("a[href='/forgot_password']").click
     page.should have_css 'h1', text: "Forgot Password?"
  end

  scenario "user enters valid, invalid and blank email and clicks for reset " do
    
    visit forgot_password_path
    click_button('Send Email')
    page.should have_css 'h1', text: "Forgot Password?"
    page.should have_content "You must enter your email address."

    fill_in "Email Address", with: 'invalid@email.com'
    click_button('Send Email')
    page.should have_css 'h1', text: "Forgot Password?"
    page.should have_content "The email address is not in the system."

    fill_in "Email Address", with: 'me@them.com'
    click_button('Send Email')
    page.should have_css 'p', text: "We have sent an email with instruction to reset your password."
  end

  scenario "user interacts with reset email" do
    visit forgot_password_path
    fill_in "Email Address", with: alice.email
    click_button('Send Email')
    message = ActionMailer::Base.deliveries.last
    message.body.should include(
      alice.full_name, 
      "To reset your password, please click on the following link:",
      "http://localhost:3000/reset_passwords/#{alice.token}"  
      )

    visit "http://localhost:3000/reset_passwords/#{alice.token}"
    page.should have_css 'h1', text: "Reset Your Password"
  end

  scenario "user interacts with password reset page" do
    visit reset_password_path(alice.token)
    page.should have_css 'h1', text: "Reset Your Password"
    old_token = alice.token

    fill_in "New Password", with: "new_pass"
    click_button("Reset Password")
    page.should have_css 'h1', text: "Sign In"
    
    fill_in 'Email Address', with: alice.email
    fill_in 'Password', with: "new_pass"
    click_button "Sign in"
    page.should have_content alice.full_name

    #retry expired token
    visit reset_password_path(old_token)
    page.should have_css 'p', text: 'Your reset password link is expired.'
  end


end