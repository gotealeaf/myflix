require 'spec_helper'

feature "User sign in" do
  scenario "with existing email and password" do
    paco = Fabricate :user, email: "paq2@paq.com", password: "12345678", password_confirmation: "12345678", full_name: "Mario"
    sign_in paco 

    page.should have_content "Wellcome #{paco.full_name}"
  end

  scenario "with non existing email and passworrd" do
    visit sign_in_path
    fill_in "Email", with: "paq2@paq.com"
    fill_in "Password", with: "12345678"
    click_button "Sign in"

    page.should have_content "email and/or password are not correct."
  end
end