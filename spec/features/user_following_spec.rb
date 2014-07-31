require 'spec_helper'

feature 'User following' do
  scenario "user follows and unfollows somoeone " do
    lalaine = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: lalaine, video: video)

    sign_in
    click_on_video_on_home_page(video)

    click_link lalaine.username
    click_link "Follow"
    expect(page).to have_content(lalaine.username)

    unfollows(lalaine)
  end

  def unfollows(user)
    find("a[data-method='delete']").click
  end
end