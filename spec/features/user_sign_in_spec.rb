require 'spec_helper'
require 'pry'

feature "user sign in" do
  scenario 'user signing in using valid credentials' do
    adam = Fabricate(:user)
    visit login_path
    fill_in "Email", :with => adam.email
    fill_in "Password", :with => adam.password
    click_button "Submit"
    expect(page).to have_content "You are now logged in."
  end
end
