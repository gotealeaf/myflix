require 'spec_helper'

feature "following user" do
  let!(:current_user) { Fabricate(:user) }
  let!(:another_user) { Fabricate(:user) }
  let!(:cat) { Fabricate(:category) }
  let!(:video1) { Fabricate(:video, category: cat) }
  let!(:review1) { Fabricate(:review, creator: another_user, video: video1) }

  scenario "user can follow and unfollow another user" do
    sign_in(current_user)
    click_on_video_on_home_page(video1)

    click_link "#{another_user.full_name}"
    expect(page).to have_content(another_user.full_name)

    click_link "Follow"
    expect(page).to have_content(another_user.full_name)

    visit following_people_path
    unfollow(another_user)

    visit following_people_path
    expect(page).not_to have_content(another_user.full_name)

  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end
