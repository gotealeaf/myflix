require 'spec_helper'

feature 'User following' do
  scenario "user follows and unfollows someone" do
  
    amanda = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: amanda, video: video)

    sign_in
    click_on_video_on_home_page(video)

    click_link amanda.full_name
    click_link "Follow"
    expect(page).to have_content(amanda.full_name)

    unfollow(amanda)
    expect(page).not_to have_content(amanda.full_name)
  end

  def unfollow(user)
  	find("a[data-method='delete']").click
  end
end