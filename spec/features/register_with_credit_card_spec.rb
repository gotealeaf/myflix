require "spec_helper"

feature "register with credit card", { js: true, vcr: true } do
  
  background do
    visit root_path
    click_link "Sign Up Now!"
  end

  scenario "user tries to register, but inputs on top of form are invalid" do
    bad_top_data
    good_bottom_data
    sign_up_and_check_for "can't be blank"
  end

  scenario "user tries to register, but inputs on top of form are invalid and credit card is also invalid" do
    bad_top_data
    bad_bottom_data
    sign_up_and_check_for "Your card's security code is invalid."
  end

  scenario "user tries to register, but inputs on top of form are invalid and credit card is declined" do
    bad_top_data
    declined_bottom_data
    sign_up_and_check_for "can't be blank"
  end

  scenario "user tries to register, but credit card is invalid" do
    good_top_data
    bad_bottom_data
    sign_up_and_check_for "Your card's security code is invalid."
  end

  scenario "user tries to register, but credit card is declined" do
    good_top_data
    declined_bottom_data
    sign_up_and_check_for "Your card was declined."
  end

  scenario "user successfully registers" do
    good_top_data
    good_bottom_data
    sign_up_and_check_for "Thanks for becoming a member of MyFLix!"
  end

  private

  def good_top_data
    fill_in "Email Address", with: "alice@example.com"
    fill_in "Password", with: "alice"
    fill_in "Full Name", with: "Alice Humperdink"
  end

  def bad_top_data
    fill_in "Email Address", with: "alice@example.com"
    fill_in "Password", with: "alice"
  end

  def good_bottom_data
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "3 - March", from: "date_month"
    select "2016", from: "date_year"
  end

  def bad_bottom_data
    fill_in "Credit Card Number", with: "4242424242424242"
    select "3 - March", from: "date_month"
    select "2016", from: "date_year"
  end

  def declined_bottom_data
    fill_in "Credit Card Number", with: "4000000000000002"
    fill_in "Security Code", with: "123"
    select "3 - March", from: "date_month"
    select "2016", from: "date_year"
  end

  def sign_up_and_check_for(content)
    click_button "Sign Up"
    expect(page).to have_content(content)
  end
end