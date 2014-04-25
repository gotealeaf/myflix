require 'spec_helper'

feature "User resets password" do
  scenario "user successfully resets the password via email" do 
    alice = Fabricate(:user, password: 'old_password')
    visit_forgot_password_page
    submit_email(alice.email)
    open_email(alice.email)
    visit_reset_password_page_via_link_in_email(current_email)
    submit_new_password('new_password')
    log_in_user_with_new_password(alice, 'new_password')
  end
end

def visit_forgot_password_page
  visit login_path
  click_link "Forgot Password"
  expect(page).to have_content("Forgot Your Password?")
end

def submit_email(email)
  find('#email').set(email)
  click_button "Send Email"
  expect(page).to have_content("We have sent an email with instructions to reset your password.")
end

def visit_reset_password_page_via_link_in_email(current_email)
  expect(current_email).to have_content("Click on this link to reset it:")
  current_email.click_link("Reset Password")
  expect(page).to have_content("Reset Your Password")
end

def submit_new_password(password)
  fill_in "New Password", with: password
  click_button "Reset Password"
  expect(page).to have_content("You reset your password. Please log in.")
end

def log_in_user_with_new_password(user, password)
  fill_in "Email Address", with: user.email
  fill_in "Password", with: 'new_password'
  click_button "Sign in"
  expect(page).to have_content("Welcome, #{user.full_name}!")
end