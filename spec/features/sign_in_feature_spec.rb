require 'spec_helper'
require 'pry'

feature "login, add videos to queue and check queue works correctly" do

  # given(:video1) { Fabricate(:video) }
  given(:video2) { Fabricate(:video) }
  given(:video3) { Fabricate(:video) }
  given(:category) { Fabricate(:category) }
  given(:adam) { Fabricate(:user) }

  background do
    visit login_path
    fill_in "Email", :with => adam.email
    fill_in "Password", :with => adam.password
    click_button "Submit"
  end

  scenario "user signing in with valid credentials" do
    expect(page).to have_content "You are now logged in."
  end

  scenario "select video and go to video show page" do
    video1 = Fabricate(:video, category: category)
    visit home_path
    binding.pry
    find("video_#{video1.id}").click
    expect(page).to have_content "#{video1.title}"
  end
end
