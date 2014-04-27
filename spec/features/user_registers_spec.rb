require 'spec_helper'

feature 'User registers', {js: true, vcr: true} do
  scenario "with valid input" do
    visit register_path
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Smith"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
    click_on('Sign Up')
    expect(page).to have_text("Thank you for signing up")
  end

  scenario "with invalid input" do
    visit register_path
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Smith"
    fill_in "Credit Card Number", with: "4242424242424241"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
    click_on('Sign Up')
    expect(page).to have_text("Your card number is incorrect")
  end

  scenario "with declined credit card" do
    visit register_path
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Smith"
    fill_in "Credit Card Number", with: "4000000000000002"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
    click_on('Sign Up')
    expect(page).to have_text("Your card was declined.")
  end
end
