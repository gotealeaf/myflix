require 'spec_helper'

feature "reset_password" do
  let!(:alice) {Fabricate(:user, email: 'me@them.com')}

  scenario "user visit sign in page" do
    visit sign_in_path
    page.should have_css('#forgot_password')
  end

 scenario "user clicks forgot password button at sign in" do
    visit sign_in_path
    # find("a[id='forgot_password']").click
     find("a[href='/forgot_password']").click
    # find("a[class='btn-default']").click
    # click_button("forgot_pass")
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
    fill_in "Email Address", with: 'me@them.com'
    click_button('Send Email')
      #how do I get to the email?
    page.should have_content alice.full_name
    page.should have_content alice.token
    click_link "Reset Password"
    page.should have_css 'h1', text: "Reset Your Password"
  end

  scenario "user interacts with password reset page" do
    reset_link = ActionMailer::Base.deliveries.last.url
    visit reset_link
    old_token = alice.token

    fill_in "New Password", with: "new_pass"
    fill_in hidden_field, with: token
    click_link(@type=submit)
    page.should have_css 'h1', text: "Sign in"

    sign_in(alice)
    page.should have_content alice.full_name

    #retry expired token
    visit reset_password_path
    fill_in hidden_field, with: old_token
    fill_in "New Password", with: "another_pass"
    click_link(@type=submit)
    page.should have_css 'p', text: 'Your reset password link is expired.'
  end


end