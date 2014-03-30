require 'spec_helper'

feature 'User registers' do
  scenario "with valid input" do
    visit register_path
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Smith"
    click_on('Create')
    expect(page).to have_text("Thank you for signing up")
  end
end
