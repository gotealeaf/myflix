require 'spec_helper'

feature "User sign in" do
  scenario "with existing user" do
    Fabricate :user, email: "paq2@paq.com", password: "12345678", password_confirmation: "12345678", full_name: "Mario"
    visit sign_in_path
    fill_in "Email", with: "paq2@paq.com"
    fill_in "Password", with: "12345678"
    click_button "Sign in"

    page.should have_content "Wellcome Mario"
  end

  scenario "with existing email" do
    visit sign_in_path
    fill_in "Email", with: "paq2@paq.com"
    fill_in "Password", with: "12345678"
    click_button "Sign in"

    page.should have_content "email and/or password are not correct."
  end
end