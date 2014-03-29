require "spec_helper"

feature "User following" do
  scenario "user follows and unfollows someone" do
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    linda = Fabricate(:user)
    Fabricate(:review, user: linda, video: video)

    sign_in
    click_on_video_on_home_page(video)
    click_link linda.fullname
    click_link "Follow"

    expect(page).to have_content(linda.fullname)

    unfollows(linda)

    expect(page).not_to have_content(linda.fullname)
  end

  def unfollows(user)
    find("a[data-method='delete']").click
  end
end
