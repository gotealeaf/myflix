require 'pry'
require 'spec_helper'

feature "login and follow user and unfollow and test all aspects of feature" do
  given(:category) { Fabricate(:category) }
  given(:adam) { Fabricate(:user) }

  scenario 'login and follow and unfollow users' do

    sign_in

    bob = Fabricate(:user)
    video1 = Fabricate(:video, category: category)
    Fabricate(:video, category: category)
    Fabricate(:video, category: category)
    review1 = Fabricate(:review, user: bob, video: video1)
    review2 = Fabricate(:review, video: video1)

    visit video_path(video1)

    expect(page).to have_content "#{video1.title}"

    click_link("#{bob.fullname}")

    expect(page).to have_content "#{bob.fullname}"

    click_link("Follow")

    expect(page).to have_content("You are now successfully following #{bob.fullname}.")

    click_link("follower_#{bob.id}")

    expect(page).to have_content "You are no longer following that user."

  end

  def sign_in
    visit login_path
    fill_in "Email", :with => adam.email
    fill_in "Password", :with => adam.password
    click_button "Submit"
  end
end
