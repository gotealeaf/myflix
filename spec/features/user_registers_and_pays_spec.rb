require 'spec_helper'

feature 'User registers and pays', {js: true, vcr: true} do
  background do
    visit register_path
  end

  context "with valid user info" do
    background do
      fill_in "Email Address", with: "joe@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirm Password", with: "password"
      fill_in "Full Name", with: "Joe Doe"
    end

    scenario 'and no credit card info' do
      click_button "Sign Up"
      expect(page).to have_content("This card number looks invalid")
    end

    scenario 'and invalid credit card info' do
      fill_in "Credit Card Number", with: "4242424242424241"
      fill_in "Security Code", with: "123"
      select "7 - July", from: "date_month"
      select "2016", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("Your card number is incorrect.")
    end

    scenario 'and a bad security code' do
      fill_in "Credit Card Number", with: "4242424242424242"
      fill_in "Security Code", with: "3"
      select "7 - July", from: "date_month"
      select "2016", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("Your card's security code is invalid.")
    end

    scenario 'and a bad expiration date' do
      fill_in "Credit Card Number", with: "4242424242424242"
      fill_in "Security Code", with: "123"
      select "1 - January", from: "date_month"
      select "2014", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("Your card's expiration month is invalid.")
    end

    scenario 'and valid and good credit card info' do
      fill_in "Credit Card Number", with: "4242424242424242"
      fill_in "Security Code", with: "123"
      select "1 - January", from: "date_month"
      select "2016", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("Thank you for registering with MyFlix. You can now sign in.")
      expect(User.last.email).to eq('joe@example.com')
    end

    scenario 'and valid but declined credit card info' do
      fill_in "Credit Card Number", with: "4000000000000002"
      fill_in "Security Code", with: "123"
      select "1 - January", from: "date_month"
      select "2016", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("Your card was declined")
      expect(User.count).to eq(0)
    end
  end

  context 'with invalid user info' do
    background do
      fill_in "Email Address", with: "joe@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirm Password", with: "badpassword"
      fill_in "Full Name", with: "Joe Doe"
    end

    scenario 'and no credit card info' do
      click_button "Sign Up"
      expect(page).to have_content("This card number looks invalid")
    end

    scenario 'and invalid credit card info' do
      fill_in "Credit Card Number", with: "4242424242424241"
      fill_in "Security Code", with: "123"
      select "7 - July", from: "date_month"
      select "2016", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("Your card number is incorrect.")
    end

    scenario 'and valid but declined credit card info' do
      fill_in "Credit Card Number", with: "4000000000000002"
      fill_in "Security Code", with: "123"
      select "1 - January", from: "date_month"
      select "2016", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("doesn't match Password")
      expect(User.count).to eq(0)
    end

    scenario 'with valid and good credit card info' do
      fill_in "Credit Card Number", with: "4242424242424242"
      fill_in "Security Code", with: "123"
      select "1 - January", from: "date_month"
      select "2016", from: "date_year"
      click_button "Sign Up"

      expect(page).to have_content("doesn't match Password")
      expect(User.count).to eq(0)
    end
  end
end

