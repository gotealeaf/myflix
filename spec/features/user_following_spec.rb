require 'spec_helper'

feature 'User following' do
  scenario "following followed user" do
    sam = Fabricate(:user)
    vivian = Fabricate(:user)
    action = Fabricate(:category)
    kungfu = Fabricate(:video, title: "Kung Fu", category: action)
    Fabricate(:review, user: vivian, video: kungfu)

    sign_in(sam)
    click_on_video_on_home_page(kungfu)

    click_link vivian.full_name 
    click_link "Follow"
    expect(page).to have_content(vivian.full_name)

    unfollow(vivian)
    expect(page).not_to have_content(vivian.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end
