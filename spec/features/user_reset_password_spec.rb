require 'spec_helper'
require 'capybara/email/rspec'

feature "Password reset" do
  scenario "Forgot password" do
    ana = Fabricate :user, email: "paq5@paq.com"
    ana.update_column(:token, "123456")

    visit root_path
    click_link "Sign In"

    click_link "Forgot your password?"
    page.should have_content "We will send you an email with a link that you can use to reset your password."
    fill_in "email", with: ana.email    
    click_button "Send Email"

    open_email('paq5@paq.com')
    current_email.click_link "Reset my password"

    page.should have_content "Reset Your Password"
    fill_in "New password", with:"987654321"
    fill_in "Password confirmation", with: "987654321"
    click_button "Reset Password"

    ana.reload.authenticate("987654321").should be_true 

    clear_email
  end
end